class Array
    def all_empty?
        self.all? {|element| element.to_s.empty?}
    end
    
    def any_empyt?
        self.any? {|element| element.to_s.empty?}
    end

    def none_empty?
        !any_empyt?
    end
end