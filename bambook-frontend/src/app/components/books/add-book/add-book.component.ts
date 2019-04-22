import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { AuthService } from '../../../services/auth.service';
import { BookService } from '../../../services/book.service';

@Component({
  selector: 'app-add-book',
  templateUrl: './add-book.component.html',
  styleUrls: ['./add-book.component.css']
})
export class AddBookComponent implements OnInit {

  title: string;
  author: string;
  description: string;

  cover_photo: File;
  book_file: File;

  message: string;

  constructor(private bookService: BookService,
              private router: Router,
              private auth: AuthService) { }

  ngOnInit() {
  }

  onPhotoSelected(event) {
    this.cover_photo = event.target.files[0];
  }

  onFileSelected(event) {
    this.book_file = event.target.files[0];
  }

  submitBook() {

    if ((this.title && this.title != '') &&
      (this.author && this.author != '') &&
      (this.cover_photo && this.cover_photo != null) &&
      (this.description && this.description != null)) {

      const book = {
        book:
          {
            title: this.title,
            author: this.author,
            description: this.description,
            cover_photo: this.cover_photo,
            book_file: this.book_file
          }
      };
      this.bookService.addBook(book).subscribe((resp: any) => {
        console.log(resp.book);
        if (resp.book) {
          this.router.navigate(['/books/' + resp.book.id]);
          console.log('The book was created')
        }
        else {
          console.log(resp.message);
        }
      });
    } else {
      this.message = 'Please fill in all fields';
    }
  }

}
