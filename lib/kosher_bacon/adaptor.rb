MiniTest = Test = Module.new

module MiniTest
  module Unit
    class TestCase

      # @see skip
      SKIP = Object.new

      #
      # Hooks to perform MiniTest -> MacBacon translations
      #

      def self.inherited(subclass)
        name = subclass.to_s.sub(/^Test/, '')
        context = describe name do
          before do
            @test_case = subclass.new
            @test_case.setup if @test_case.respond_to?(:setup)
          end
          after do
            @test_case.teardown if @test_case.respond_to?(:teardown)
            @test_case = nil
          end
        end
        subclass.instance_variable_set(:@context, context)
      end

      def self.method_added(meth)
        return unless meth =~ /^test_/
        name = meth.sub(/^test_/, '').tr('_', ' ')
        @context.it name do
          skipped = catch SKIP do
            @test_case.__send__(meth)
          end
          if skipped
            Bacon::Counter[:requirements] += 1 # Convince Bacon that tests passed
          end
        end
      end

      #
      # Test control
      #

      def skip
        throw SKIP, true
      end

      def pass(_=nil)
        assert true
      end

      #
      # Assertions
      #

      # @see assert_operator
      UNDEFINED = Object.new

      def assert(test, msg=nil)
        if msg.nil?
          test.should.be.true?
        else
          Bacon::Should.new(nil).satisfy(msg) { test }
        end
        true
      end

      def refute(test, msg=nil)
        if msg.nil?
          test.should.be.false?
        else
          !assert(!test, msg)
        end
      end

      def assert_empty(obj, msg=nil)
        if msg.nil?
          obj.should.be.empty?
        else
          assert obj.empty?, msg
        end
      end

      def refute_empty(obj, msg=nil)
        if msg.nil?
          obj.should.not.be.empty?
        else
          refute obj.empty?, msg
        end
      end

      def assert_equal(exp, act, msg=nil)
        if msg.nil?
          act.should == exp
        else
          assert act == exp, msg
        end
      end

      def refute_equal(exp, act, msg=nil)
        if msg.nil?
          act.should != exp
        else
          refute act == exp, msg
        end
      end
      alias_method :assert_not_equal, :refute_equal

      def assert_in_delta(exp, act, delta=0.001, msg=nil)
        if msg.nil?
          act.should.be.close?(exp, delta)
        else
          assert delta >= (act-exp).abs, msg
        end
      end

      def refute_in_delta(exp, act, delta=0.001, msg=nil)
        if msg.nil?
          act.should.not.be.close?(exp, delta)
        else
          refute delta >= (act-exp).abs, msg
        end
      end

      def assert_in_epsilon(exp, act, epsilon=0.001, msg=nil)
        delta = epsilon * [exp.abs, act.abs].min
        assert_in_delta exp, act, delta, msg
      end

      def refute_in_epsilon(exp, act, epsilon=0.001, msg=nil)
        delta = epsilon * [exp.abs, act.abs].min
        refute_in_delta exp, act, delta, msg
      end

      def assert_includes(collection, obj, msg=nil)
        if msg.nil?
          collection.should.include?(obj)
        else
          assert collection.include?(obj), msg
        end
      end

      def refute_includes(collection, obj, msg=nil)
        if msg.nil?
          collection.should.not.include?(obj)
        else
          refute collection.include?(obj), msg
        end
      end

      def assert_instance_of(cls, obj, msg=nil)
        if msg.nil?
          obj.should.be.instance_of?(cls)
        else
          assert obj.instance_of?(cls), msg
        end
      end

      def refute_instance_of(cls, obj, msg=nil)
        if msg.nil?
          obj.should.not.be.instance_of?(cls)
        else
          refute obj.instance_of?(cls), msg
        end
      end

      def assert_kind_of(cls, obj, msg=nil)
        if msg.nil?
          obj.should.be.kind_of?(cls)
        else
          assert obj.kind_of?(cls), msg
        end
      end

      def refute_kind_of(cls, obj, msg=nil)
        if msg.nil?
          obj.should.not.be.kind_of?(cls)
        else
          refute obj.kind_of?(cls), msg
        end
      end

      def assert_match(matcher, obj, msg=nil)
        matcher = /#{Regexp.escape(matcher)}/ if String === matcher
        if msg.nil?
          obj.should =~ matcher
        else
          assert matcher =~ obj, msg
        end
      end

      def refute_match(matcher, obj, msg=nil)
        matcher = /#{Regexp.escape(matcher)}/ if String === matcher
        if msg.nil?
          obj.should.not =~ matcher
        else
          refute matcher =~ obj, msg
        end
      end
      alias_method :assert_no_match, :refute_match

      def assert_nil(obj, msg=nil)
        if msg.nil?
          obj.should.be.nil?
        else
          assert obj.nil?, msg
        end
      end

      def refute_nil(obj, msg=nil)
        if msg.nil?
          obj.should.not.be.nil?
        else
          refute obj.nil?, msg
        end
      end
      alias_method :assert_not_nil, :refute_nil

      def assert_operator(obj1, op, obj2=UNDEFINED, msg=nil)
        args = obj2 == UNDEFINED ? [op] : [op, obj2]
        if msg.nil?
          obj1.should.public_send(*args)
        else
          assert obj1.__send__(*args), msg
        end
      end

      def refute_operator(obj1, op, obj2=UNDEFINED, msg=nil)
        args = obj2 == UNDEFINED ? [op] : [op, obj2]
        if msg.nil?
          obj1.should.not.public_send(*args)
        else
          refute obj1.__send__(*args), msg
        end
      end

      def assert_output
        raise NotImplementedError
      end

      def assert_predicate(obj, predicate, msg=nil)
        if msg.nil?
          obj.should.public_send(predicate)
        else
          assert obj.__send__(predicate), msg
        end
      end

      def refute_predicate(obj, predicate, msg=nil)
        if msg.nil?
          obj.should.not.public_send(predicate)
        else
          refute obj.__send__(predicate), msg
        end
      end

      def assert_raises(*exceptions, &block)
        msg = exceptions.last if String === exceptions.last
        if msg.nil?
          block.should.raise?(*exceptions)
        else
          assert block.raise?(*exceptions), msg
        end
      end
      alias_method :assert_raise, :assert_raises

      def refute_raises(msg=nil)
        msg = exceptions.last if String === exceptions.last
        if msg.nil?
          block.should.not.raise?(*exceptions)
        else
          refute block.raise?(*exceptions), msg
        end
      end
      alias_method :assert_nothing_raised, :refute_raises

      def assert_respond_to(obj, meth, msg=nil)
        if msg.nil?
          obj.should.respond_to?(meth)
        else
          assert obj.respond_to?(meth), msg
        end
      end

      def refute_respond_to(obj, meth, msg=nil)
        if msg.nil?
          obj.should.not.respond_to?(meth)
        else
          refute obj.respond_to?(meth), msg
        end
      end

      def assert_same(exp, act, msg=nil)
        if msg.nil?
          act.should.equal?(exp)
        else
          assert act.equal?(exp), msg
        end
      end

      def refute_same(exp, act, msg=nil)
        if msg.nil?
          act.should.not.equal?(exp)
        else
          refute act.equal?(exp), msg
        end
      end
      alias_method :assert_not_same, :refute_same

      def assert_send(send_ary, msg=nil)
        obj, meth, *args = send_ary
        if msg.nil?
          obj.should.public_send(meth, *args)
        else
          assert obj.__send__(meth, *args), msg
        end
      end

      def refute_send(send_ary, msg=nil)
        obj, meth, *args = send_ary
        if msg.nil?
          obj.should.not.public_send(meth, *args)
        else
          refute obj.__send__(meth, *args), msg
        end
      end
      alias_method :assert_not_send, :refute_send

      def assert_throws(tag, msg=nil, &block)
        if msg.nil?
          block.should.throw?(tag)
        else
          assert block.throw?(tag), msg
        end
      end

      def refute_throws(msg=nil)
        if msg.nil?
          block.should.not.throw?(tag)
        else
          refute block.throw?(tag), msg
        end
      end
      alias_method :assert_nothing_thrown, :refute_throws

      def assert_block(msg=nil, &block)
        if msg.nil?
          block.should.call
        else
          assert yield, msg
        end
      end

    end
  end
end
