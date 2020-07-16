From: ahmadkhorrami <ahmadkhorrami@ut.ac.ir>
Subject: Re: [lttng-dev] Capturing User-Level Function Calls/Returns
Date: Thu, 16 Jul 2020 20:56:13 +0430
Message-ID: <7f301943d8e46bb21068c2d8017e7b4f@ut.ac.ir>
References: <e9c7400ff0075f3beba2863c4432a905@ut.ac.ir>
 <20200715142849.0bfe909a@oasis.local.home>
 <83963025.14828.1594838718290.JavaMail.zimbra@efficios.com>
 <98de6fe15a816d8f06ba3d5df0f10540@ut.ac.ir>
 <20200715174858.4698803c@oasis.local.home>
 <489547987.230950.1594861561764.JavaMail.zimbra@polymtl.ca>
 <20200716014932.GB10566@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-trace-users-owner@vger.kernel.org>
In-Reply-To: <20200716014932.GB10566@redhat.com>
Sender: linux-trace-users-owner@vger.kernel.org
To: "Frank Ch. Eigler" <fche@redhat.com>
Cc: Michel Dagenais <michel.dagenais@polymtl.ca>, Steven Rostedt <rostedt@goodmis.org>, linux-trace-users-owner@vger.kernel.org, linux-trace-users <linux-trace-users@vger.kernel.org>, lttng-dev <lttng-dev@lists.lttng.org>, Namhyung Kim <namhyung@kernel.org>
List-Id: lttng-dev@lists.lttng.org

Hi Frank,

Thanks for the point!

Regards.


On 2020-07-16 06:19, Frank Ch. Eigler wrote:

> Hi -
> 
>> If you can afford a more invasive tool, that requires a lot of
>> memory and stops your application for quite some time, you can look
>> at approaches like dyninst that decompile the binary, insert
>> instrumentation code and reassemble the code.
> 
>> https://dyninst.org/
> 
> For the record, systemtap includes a backend that uses dyninst as a
> pure userspace backend.
> 
> % cat foo.c
> #include <stdio.h>
> 
> int foo() {
> printf("foo\n");
> return 1;
> }
> 
> int main() {
> foo();
> }
> 
> % gcc -g foo.c
> 
> % stap --runtime=dyninst -e '
> probe process.function("*").{call,return} { println(pp()) }
> ' -c a.out
> 
> foo
> process("/home/fche/a.out").function("main@/home/fche/foo.c:8").call
> process("/home/fche/a.out").function("foo@/home/fche/foo.c:3").call
> process("/home/fche/a.out").function("foo@/home/fche/foo.c:3").return
> process("/home/fche/a.out").function("main@/home/fche/foo.c:8").return
> 
> - FChE
