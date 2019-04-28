import { Component } from '@angular/core';
import { BookService } from '../../../../services/book.service';
import { ActivatedRoute } from '@angular/router';

@Component({
  selector: 'app-add-review',
  templateUrl: './add-review.component.html',
  styleUrls: ['./add-review.component.css']
})
export class AddReviewComponent {
  comment;
  rating = 5;
  bookId;

  message: string;

  constructor(private bookService: BookService, private activatedRoute: ActivatedRoute) {
    this.bookId = this.activatedRoute.snapshot.params['id']
  }

  addReview() {

    if ((this.rating) && (this.comment && this.comment != '')) {

      this.bookService.addReview(this.comment, this.rating, this.bookId).subscribe((resp: any) => {
        if (!resp.review) {
          console.log(resp.message);
        } else {
          window.location.reload();
        }
      });
    } else {
      this.message = 'Please fill in all fields';
    }
  }

}
