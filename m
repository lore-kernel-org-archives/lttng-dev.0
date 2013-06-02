From: Aryeh Weinreb <weinrea@gmail.com>
Subject: Re: linking c++ with shared object tracepoints
Date: Sun, 2 Jun 2013 10:47:24 +0300
Message-ID: <CAE5ibEmsiqDZttzcoordhkrh=kQeULYyKdC6jSS8Tu9gWgpWcw__16881.0721407228$1370159288$gmane$org@mail.gmail.com>
References: <CAE5ibEn5d479UzR4_zFt3nj2T6pbS94ZS50F=dkxZN3RzarvfQ@mail.gmail.com>
	<CA+jJMxusCXn9=F3dQ+ss1mGYtjv0NPXWuYWb3tLukdS1QFwtBw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-pd0-f178.google.com ([209.85.192.178])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <weinrea@gmail.com>) id 1Uj30k-0000Xf-Fn
	for lttng-dev@lists.lttng.org; Sun, 02 Jun 2013 03:47:30 -0400
Received: by mail-pd0-f178.google.com with SMTP id w10so14914pde.37
	for <lttng-dev@lists.lttng.org>; Sun, 02 Jun 2013 00:47:24 -0700 (PDT)
In-Reply-To: <CA+jJMxusCXn9=F3dQ+ss1mGYtjv0NPXWuYWb3tLukdS1QFwtBw@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: =?ISO-8859-1?Q?J=E9r=E9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

>> Is supported to link c++ code with c compiled tracepoints put it a dynamic lib?

I mean to say the tracepoints put _in_ a dynamic lib before linking
with c++ code.
>
> Yes, I just tried it here.

Could you show me how with the easy-ust example?

> The header is probably fine and I'd advise againt modifying it without
> careful thought. Could you provide a short example reproducing the
> problem?

$cd doc/examples/easy-ust/
$ g++ -DTRACEPOINT_PROBE_DYNAMIC_LINKAGE  -I. -c -o sample.o sample.c
sample.c: In function 'int main(int, char**)':
sample.c:38: warning: deprecated conversion from string constant to 'char*'
$ gcc -fPIC -I. -c -o tp.o tp.c
$ gcc -I. -shared -o libtp.so tp.o
$ g++ -o sample sample.o -ldl -llttng-ust -L. -ltp
/usr/bin/ld: sample: hidden symbol `tracepoint_dlopen' in sample.o is
referenced by DSO
/usr/bin/ld: final link failed: Nonrepresentable section on output
collect2: ld returned 1 exit status
