From: =?ISO-8859-1?Q?J=E9r=E9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: linking c++ with shared object tracepoints
Date: Tue, 4 Jun 2013 11:44:57 -0400
Message-ID: <CA+jJMxt=PiBs3H-1jAsCSwZTnQFTQ85_WTyUNYdD6tbGSD+dPQ__26946.5568279431$1370360735$gmane$org@mail.gmail.com>
References: <CAE5ibEn5d479UzR4_zFt3nj2T6pbS94ZS50F=dkxZN3RzarvfQ@mail.gmail.com>
	<CA+jJMxusCXn9=F3dQ+ss1mGYtjv0NPXWuYWb3tLukdS1QFwtBw@mail.gmail.com>
	<CAE5ibEmsiqDZttzcoordhkrh=kQeULYyKdC6jSS8Tu9gWgpWcw@mail.gmail.com>
	<CA+jJMxvNnYEQPdJhnLRKmFR=v-VVg5HNbn7-Z1yoYszTEk2XoA@mail.gmail.com>
	<CAE5ibEn-qhRBzBz7bbF5uJWrJQQhVj=Unhymy_Uw-ye8jRpEJQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-we0-f176.google.com ([74.125.82.176])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jeremie.galarneau@gmail.com>) id 1UjtPz-00029f-QC
	for lttng-dev@lists.lttng.org; Tue, 04 Jun 2013 11:45:04 -0400
Received: by mail-we0-f176.google.com with SMTP id t56so360199wes.7
	for <lttng-dev@lists.lttng.org>; Tue, 04 Jun 2013 08:44:57 -0700 (PDT)
In-Reply-To: <CAE5ibEn-qhRBzBz7bbF5uJWrJQQhVj=Unhymy_Uw-ye8jRpEJQ@mail.gmail.com>
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

Just to isolate the problem further, can you give me the version of
lttng-ust you have installed and which distribution you are using?

On Tue, Jun 4, 2013 at 11:37 AM, Aryeh Weinreb <weinrea@gmail.com> wrote:
>> I prepared a quick and dirty example based on the "demo" project.
>> Replace the Makefile and demo.c files with these:
>> https://gist.github.com/jgalar/5706595
>>
>> This will compile a C++ application which links against the
>> lttng-ust-provider-ust-tests-demo3.so provider.
>>
>> Resulting trace:
>> [10:59:42.399354875] (+?.?????????) mercury:demo:16256
>> ust_tests_demo3:done: { cpu_id =3D 4 }, { value =3D 42 }
>>
>> Regards,
>> J=E9r=E9mie
>
> Thanks.
> Unfortunately, this is not working for me.
>
> Making all in demo
> make[3]: Entering directory `/home/nkw643/lttng-ust-2.1.2/tests/demo'
> g++   -c -o demo.o demo.cpp
> gcc  -I.  -fpic -c -o tp3.o tp3.c
> gcc -shared -o lttng-ust-provider-ust-tests-demo3.so  -llttng-ust tp3.o
> g++ -o demo demo.o lttng-ust-provider-ust-tests-demo3.so -L. -ldl
>   -Wl,-rpath=3D.
> /usr/bin/ld: demo: hidden symbol `tracepoint_dlopen' in demo.o is
> referenced by DSO
> /usr/bin/ld: final link failed: Nonrepresentable section on output
> collect2: ld returned 1 exit status
>
> $ nm -s demo.o | grep tracepoint_dlopen
> 0000000000000020 V tracepoint_dlopen
> $ nm -s .libs/liblttng-ust-provider-ust-tests-demo3.so   | grep
> tracepoint_dlopen
>                  U tracepoint_dlopen
>
> $ readelf -s demo.o  | grep tracepoint_dlopen
>     34: 0000000000000020    48 OBJECT  WEAK   HIDDEN     6 tracepoint_dlo=
pen
> $ readelf -s .libs/liblttng-ust-provider-ust-tests-demo3.so   | grep
> tracepoint_dlopen
>      6: 0000000000000000     0 NOTYPE  GLOBAL DEFAULT  UND tracepoint_dlo=
pen
>     67: 0000000000000000     0 NOTYPE  GLOBAL DEFAULT  UND tracepoint_dlo=
pen
>
> $readelf -d demo.o  | grep tracepoint_dlopen
> $
> $readelf -d .libs/liblttng-ust-provider-ust-tests-demo3.so  | grep
> tracepoint_dlopen
> $



-- =

J=E9r=E9mie Galarneau
EfficiOS Inc.
http://www.efficios.com
