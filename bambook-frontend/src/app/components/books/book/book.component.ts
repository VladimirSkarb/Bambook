import { Component} from '@angular/core';
import { BookService } from '../book.service';
import { ActivatedRoute } from '@angular/router';

@Component({
  selector: 'app-book',
  templateUrl: './book.component.html',
  styleUrls: ['./book.component.css']
})
export class BookComponent {
  book;

  constructor(private bookService: BookService,
              private activatedRoute: ActivatedRoute
  ){
    this.bookService.getBookById(this.activatedRoute.snapshot.params['id'])
      .then((resp) => {
        this.book = resp;
        console.log(this.book);
      });
  }
}
