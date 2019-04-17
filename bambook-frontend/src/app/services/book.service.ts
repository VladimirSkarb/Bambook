import { Injectable} from '@angular/core';
import { HttpClient, HttpHeaders } from '@angular/common/http';


@Injectable({
  providedIn: 'root'
})
export class BookService {
  apiUrl: string;

  authToken =  localStorage.getItem('access_token');

  httpOptions = {
    headers: new HttpHeaders({ 'Authorization': this.authToken })
  };

  constructor(private http: HttpClient) {
    this.apiUrl = 'http://localhost:3000/api/v1/books';
  }

  addBook(book) {
    const fd = new FormData();
    fd.append('book[title]', book.book.title);
    fd.append('book[author]', book.book.author);
    fd.append('book[description]', book.book.description);
    fd.append('book[cover_photo]', book.book.cover_photo);
    fd.append('book[book_file]', book.book.book_file);

    return this.http.post(`${this.apiUrl}`, fd, this.httpOptions);
  }

  getBookById(bookId): Promise<Object> {
    return this.http.get(`${this.apiUrl}/${bookId}`).toPromise().then((resp) => {
      let book = resp;
      return book;
    });
  }
  deleteBook(bookId): Promise<Object> {
    console.log(`from book.service delete method......`);
    return this.http.delete(`${this.apiUrl}/${bookId}`, this.httpOptions).toPromise().then((resp) => {
      let status = resp;
      console.log('book', status);
      return status;
    });
  }
  updateBook(bookId, book) {
    const fd = new FormData();
    fd.append('book[title]', book.book.title);
    fd.append('book[author]', book.book.author);
    fd.append('book[description]', book.book.description);
    fd.append('book[cover_photo]', book.book.cover_photo);
    fd.append('book[book_file]', book.book.book_file);

    return this.http.put(`${this.apiUrl}/${bookId}`, fd, this.httpOptions);
  }
}
