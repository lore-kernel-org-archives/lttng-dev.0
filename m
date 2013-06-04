From: =?ISO-8859-1?Q?J=E9r=E9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: linking c++ with shared object tracepoints
Date: Tue, 4 Jun 2013 11:09:43 -0400
Message-ID: <CA+jJMxvNnYEQPdJhnLRKmFR=v-VVg5HNbn7-Z1yoYszTEk2XoA__18601.2753555135$1370358618$gmane$org@mail.gmail.com>
References: <CAE5ibEn5d479UzR4_zFt3nj2T6pbS94ZS50F=dkxZN3RzarvfQ@mail.gmail.com>
	<CA+jJMxusCXn9=F3dQ+ss1mGYtjv0NPXWuYWb3tLukdS1QFwtBw@mail.gmail.com>
	<CAE5ibEmsiqDZttzcoordhkrh=kQeULYyKdC6jSS8Tu9gWgpWcw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-wi0-f169.google.com ([209.85.212.169])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jeremie.galarneau@gmail.com>) id 1Ujsrt-0001rN-Bb
	for lttng-dev@lists.lttng.org; Tue, 04 Jun 2013 11:09:49 -0400
Received: by mail-wi0-f169.google.com with SMTP id hn14so3974561wib.2
	for <lttng-dev@lists.lttng.org>; Tue, 04 Jun 2013 08:09:43 -0700 (PDT)
In-Reply-To: <CAE5ibEmsiqDZttzcoordhkrh=kQeULYyKdC6jSS8Tu9gWgpWcw@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Aryeh Weinreb <weinrea@gmail.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

On Sun, Jun 2, 2013 at 3:47 AM, Aryeh Weinreb <weinrea@gmail.com> wrote:
>>> Is supported to link c++ code with c compiled tracepoints put it a dyna=
mic lib?
>
> I mean to say the tracepoints put _in_ a dynamic lib before linking
> with c++ code.
>>
>> Yes, I just tried it here.
>
> Could you show me how with the easy-ust example?

I prepared a quick and dirty example based on the "demo" project.
Replace the Makefile and demo.c files with these:
https://gist.github.com/jgalar/5706595

This will compile a C++ application which links against the
lttng-ust-provider-ust-tests-demo3.so provider.

Resulting trace:
[10:59:42.399354875] (+?.?????????) mercury:demo:16256
ust_tests_demo3:done: { cpu_id =3D 4 }, { value =3D 42 }

Regards,
J=E9r=E9mie

>
>> The header is probably fine and I'd advise againt modifying it without
>> careful thought. Could you provide a short example reproducing the
>> problem?
>
> $cd doc/examples/easy-ust/
> $ g++ -DTRACEPOINT_PROBE_DYNAMIC_LINKAGE  -I. -c -o sample.o sample.c
> sample.c: In function 'int main(int, char**)':
> sample.c:38: warning: deprecated conversion from string constant to 'char=
*'
> $ gcc -fPIC -I. -c -o tp.o tp.c
> $ gcc -I. -shared -o libtp.so tp.o
> $ g++ -o sample sample.o -ldl -llttng-ust -L. -ltp
> /usr/bin/ld: sample: hidden symbol `tracepoint_dlopen' in sample.o is
> referenced by DSO
> /usr/bin/ld: final link failed: Nonrepresentable section on output
> collect2: ld returned 1 exit status



-- =

J=E9r=E9mie Galarneau
EfficiOS Inc.
http://www.efficios.com
