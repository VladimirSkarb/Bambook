import { BrowserModule } from '@angular/platform-browser';
import { NgModule } from '@angular/core';
import { FormsModule } from '@angular/forms';

import { AppRoutingModule } from './app-routing.module';
import { AppComponent } from './app.component';
import { HttpClientModule } from '@angular/common/http';
import { JwtModule } from '@auth0/angular-jwt';
import {HomeComponent} from './components/home/home.component';
import {BooksComponent} from './components/books/books.component';
import {MenuComponent} from './components/menu/menu.component';
import { BookComponent } from './components/books/book/book.component';
import { AddBookComponent } from './components/books/add-book/add-book.component';

@NgModule({
  declarations: [
    AppComponent,
    MenuComponent,
    BooksComponent,
    HomeComponent,
    BookComponent,
    AddBookComponent
  ],
  imports: [
    BrowserModule,
    FormsModule,
    HttpClientModule,
    AppRoutingModule,
    JwtModule.forRoot({
      config: {
        tokenGetter: function  tokenGetter()  {
          return     localStorage.getItem('access_token'); },
        // whitelistedDomains: ['localhost:3000'],
        blacklistedRoutes: ['http://localhost:3000/api/v1/users/login', 'http://localhost:3000/api/v1/users/register']
      }
    })
  ],
  providers: [],
  bootstrap: [AppComponent]
})
export class AppModule { }
