import { Component } from '@angular/core';
import { HttpClient, HttpParams} from '@angular/common/http';
import {parseSelectorToR3Selector} from "@angular/compiler/src/core";
import { PagerService } from '../../services/pager.service';

@Component({
  selector: 'app-books',
  templateUrl: './books.component.html',
  styleUrls: ['./books.component.css']
})
export class BooksComponent {
  title = 'Books';
  books;
  books_count;
  current_page;
  pager: any = {};
  pagedItems: any[];

  constructor(private http: HttpClient, private pagerService: PagerService ) {
    http.get('http://localhost:3000/api/v1/books').toPromise().then((resp) => {
      this.books = resp;
      this.books_count = this.books.books_count
      this.setPage(1)
      });
    }

    getPage(page: number) {
      let params = new HttpParams({fromObject:{page: `${page}`}});
      return this.http.get(`http://localhost:3000/api/v1/books`, {params}).toPromise().then((resp) => {
        this.books = resp;
        console.log(this.books.current_page)
        console.log(this.books)
        this.setPage(page)
      });
    }

  setPage(page: number) {
    // get pager object from service
    this.pager = this.pagerService.getPager(this.books_count, page);
    console.log(this.pager)

    // get current page of items
    this.pagedItems = this.books_count.slice(this.pager.startIndex, this.pager.endIndex + 1);
    console.log(this.pagedItems)
  }

  }
