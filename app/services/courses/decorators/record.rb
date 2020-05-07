module Courses
  module Decorators
    class Record < SimpleDelegator
      def next_group
        groups.allowed_to_check_in.first.start_date
      end

      def users_count
        users.count
      end
    end
  end
end
