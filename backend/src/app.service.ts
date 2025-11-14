import { Inject, Injectable, OnModuleInit } from '@nestjs/common';
import type { ClientGrpc } from '@nestjs/microservices';
import { Observable } from 'rxjs';
import { GreeterClient, HelloReply } from './proto/ai.pb';

@Injectable()
export class AppService implements OnModuleInit {
  private greeterService: GreeterClient;

  constructor(@Inject('GREETER_PACKAGE') private client: ClientGrpc) {}

  onModuleInit() {
    this.greeterService = this.client.getService<GreeterClient>('Greeter');
  }

  getHello(name: string): Observable<HelloReply> {
    return this.greeterService.sayHello({ name });
  }
}
