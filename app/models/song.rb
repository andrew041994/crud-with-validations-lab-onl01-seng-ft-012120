class Song < ApplicationRecord
    validates :title, presence: true
    validates :artist_name, presence: true
    validates :genre, presence: true
    validate :reject_duplicate
    validates :release_year, presence: true,
        if: :released?
    validate :date_error
   


    def reject_duplicate
        if Song.all.any? {|s| s.title == title && s.artist_name == artist_name && s.release_year == release_year}
            errors.add(:title, "Song already exists")
        end
    end

    def date_error
        if release_year.present? && release_year > Date.today.year 
            errors.add(:release_year, "can not have future release year")
        end
    end
end
