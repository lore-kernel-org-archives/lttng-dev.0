From: "Frank Ch. Eigler" <fche@redhat.com>
Subject: Re: [lttng-dev] Capturing User-Level Function Calls/Returns
Date: Wed, 15 Jul 2020 21:49:32 -0400
Message-ID: <20200716014932.GB10566@redhat.com>
References: <e9c7400ff0075f3beba2863c4432a905@ut.ac.ir>
 <20200715142849.0bfe909a@oasis.local.home>
 <83963025.14828.1594838718290.JavaMail.zimbra@efficios.com>
 <98de6fe15a816d8f06ba3d5df0f10540@ut.ac.ir>
 <20200715174858.4698803c@oasis.local.home>
 <489547987.230950.1594861561764.JavaMail.zimbra@polymtl.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-trace-users-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <489547987.230950.1594861561764.JavaMail.zimbra@polymtl.ca>
Sender: linux-trace-users-owner@vger.kernel.org
To: Michel Dagenais <michel.dagenais@polymtl.ca>
Cc: Steven Rostedt <rostedt@goodmis.org>, ahmadkhorrami <ahmadkhorrami@ut.ac.ir>, linux-trace-users-owner@vger.kernel.org, linux-trace-users <linux-trace-users@vger.kernel.org>, lttng-dev <lttng-dev@lists.lttng.org>, Namhyung Kim <namhyung@kernel.org>
List-Id: lttng-dev@lists.lttng.org

Hi -

> If you can afford a more invasive tool, that requires a lot of
> memory and stops your application for quite some time, you can look
> at approaches like dyninst that decompile the binary, insert
> instrumentation code and reassemble the code.

> https://dyninst.org/

For the record, systemtap includes a backend that uses dyninst as a
pure userspace backend.


% cat foo.c
#include <stdio.h>

int foo() {
  printf("foo\n");
  return 1;
}

int main() {
  foo();
}

% gcc -g foo.c

% stap --runtime=dyninst -e '
   probe process.function("*").{call,return} { println(pp()) }
' -c a.out

foo
process("/home/fche/a.out").function("main@/home/fche/foo.c:8").call
process("/home/fche/a.out").function("foo@/home/fche/foo.c:3").call
process("/home/fche/a.out").function("foo@/home/fche/foo.c:3").return
process("/home/fche/a.out").function("main@/home/fche/foo.c:8").return


- FChE
