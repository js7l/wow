import "jquery-bar-rating";
import $ from 'jquery';

const initStarRating = () => {
  $('.review-book-form').barrating({
    theme: 'css-stars'
  });
};

export { initStarRating };
