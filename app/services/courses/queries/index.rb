module Courses
  module Queries
    class Index < Core::Operation
      def initialize(model: Course)
        @model = model
      end

      def call(sort_by)
        Try() do
          sort(courses, sort_by)
        end.to_result
      end

      private

      attr_reader :model

      def courses
        @courses ||= model.includes(:groups)
      end

      def sort(courses, sort_rule)
        return courses if sort_rule.blank?

        field, direction = prepare_sorting_rules(sort_rule)

        case field
        when :name
          courses.order({field => direction})
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
