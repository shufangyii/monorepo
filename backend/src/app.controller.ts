import { Controller, Get, Param } from '@nestjs/common';
import { AppService } from './app.service';
import { Observable } from 'rxjs';
import { map } from 'rxjs/operators';

@Controller()
export class AppController {
  constructor(private readonly appService: AppService) {}

  @Get('/hello/:name')
  getHello(@Param('name') name: string): Observable<string> {
    return this.appService.getHello(name).pipe(map((reply) => reply.message));
  }
}
