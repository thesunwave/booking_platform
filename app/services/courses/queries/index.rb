module Courses
  module Queries
    class Index < Core::Operation
      def initialize(model, sort_by = {})
        @model = model
        @sort_by = sort_by
      end

      def call
        Try() do
          sort(courses, sort_by)
        end.to_result
      end

      private

      attr_reader :model, :sort_by

      def courses
        @courses ||= model.includes(:groups)
      end

      def sort(courses, sort_rule)
        return courses if sort_rule.nil? || sort_rule.empty?

        field, direction = prepare_sorting_rules(sort_rule)

        case field
        when :name
          courses.order({field => direction})
          # courses.select("courses.*", 'COUNT("groups_users"."user_id") as users_count ').group('courses.id')#.order({field => direction})
        when :groups
          courses.order("groups.start_date #{direction}")
        else
          courses
        end
      end

      def prepare_sorting_rules(rule)
        key, value = rule.split('_').map(&:to_sym)

        return [key, value] if value.in?([:asc, :desc])

        [key, :asc]
      end
    end
  end
end
