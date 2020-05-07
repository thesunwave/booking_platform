module Courses
  module ViewModels
    class Index < Core::Operation
      attr_reader :relation

      def initialize(relation)
        @relation = relation
      end

      def start_date
        relation.
      end
    end
  end
end
