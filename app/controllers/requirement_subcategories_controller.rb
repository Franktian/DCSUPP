class RequirementSubcategoriesController < ApplicationController

	def create

		param = params[:requirement_subcategories]
		category = param[:column_type].to_i

		@new_category = RequirementSubcategory.new()

	    @new_category.update_attribute(:requirement_category_id, param[:category])
	    @new_category.update_column(:student_attribute, param[:student_attribute])
	    @new_category.update_column(:sub_category_name, param[:item_title])

		case category
		when 1 #Input Number
			@new_category.update_column(:attribute_type, "InputNumber")
			if param[:decimal]
				@new_category.update_column(:regex, param[:decimal])
			end

			if param[:min_value]
				@new_category.update_column(:lower_limit, param[:minimumValue].to_i)
			end

			if param[:max_value]
				@new_category.update_column(:upper_limit, param[:maximumValue].to_i)
			end
		when 2 #Input Date
			@new_category.update_column(:attribute_type, "InputDate")
			if param[:before_date]
				@new_category.update_column(:lower_limit, param[:start_date].to_formatted_s(:db))
			end

			if param[:after_date]
				@new_category.update_column(:upper_limit, param[:after_date].to_formatted_s(:db))
			end

		when 3 #Boolean
			@new_category.update_column(:attribute_type, "Boolean")
			@new_category.update_column(:placeholder, param[:boolean_attribute])

		when 4 #Input Field
			@new_category.update_column(:attribute_type, "InputField")
			if param[:regex]
				@new_category.update_column(:regex, param[:regex_equation])
			end

			if param[:max_str_len]
				@new_category.update_column(:upper_limit, param[:input_max_length])
			end

			if param[:min_str_len]
				@new_category.update_column(:lower_limit, param[:input_min_length])
			end

			if param[:placeholder]
				@new_category.update_column(:placeholder, param[:placeholder_value])
			end

		else 
			puts category
		end

		if @new_category.save
			#Category Created
		else
			@errors = @new_category.errors
			@new_category.destroy
	    end

	    @subcategory = RequirementSubcategory.where(requirement_category_id: 
			param[:category])

		respond_to do |format|
	    	format.js
	    end
	end
	
end
