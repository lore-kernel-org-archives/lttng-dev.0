From: Simon Marchi <simon.marchi@polymtl.ca>
Subject: Re: (no subject)
Date: Wed, 22 Jan 2014 08:39:00 -0500
Message-ID: <CAFXXi0=xW=2CKSgcJuRZCx3MzTE-_gtxEm+kM+cM1LFWcHu=Wg__4453.66648859835$1390398031$gmane$org@mail.gmail.com>
References: <CA+knAyLjni_imS1h=+==+Gqax9ZAQu0k5Wxi0ztjph_J=LZJWw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <thundersim@gmail.com>) id 1W5y1n-0002Yo-Vi
	for lttng-dev@lists.lttng.org; Wed, 22 Jan 2014 08:39:40 -0500
Received: by mail-ie0-f174.google.com with SMTP id tp5so5208833ieb.33
	for <lttng-dev@lists.lttng.org>; Wed, 22 Jan 2014 05:39:30 -0800 (PST)
In-Reply-To: <CA+knAyLjni_imS1h=+==+Gqax9ZAQu0k5Wxi0ztjph_J=LZJWw@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mehran Khan <i@mehrankhan.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Hi Mehran,

I'll try to correct you where I can.

On 21 January 2014 18:34, Mehran Khan <i@mehrankhan.com> wrote:
> Hello everyone,
> I have been trying to instrument the Apache web server, the latest version
> (2.4.7 from the URL http://httpd.apache.org/download.cgi#apache24) for LT=
Tng
> UST tracing
> 1. To start with the simplest case, I created a *.tp file named
> smallestTracePoint.tp with the content below
>     TRACEPOINT_EVENT(
>     mk,
>     apache_process_entry,
>     TP_ARGS(),
>     TP_FIELDS()
>   )

This is good.

> 2. Then I ran the following
>    lttng-gen-tp smallestTracePoint.tp -o smallestTracePoint.h -o
> smallestTracePoint.c
>
> which generated the files smallestTracePoint.c and smallestTracePoint.h

You can just say
  $ lttng-gen-tp smallestTracePoint.tp
and it will generate the .h and .c.

> 3. Then, I put the smallestTracePoint.h and smallestTracePoint.c in
> httpd-2.4.7/server directory,
> included  smallestTracePoint.h in the main.c  file and added trace points=
 in
> the int main(int argc, const char * const argv[]) and *init_process(int
> *argc, const char * const * *argv) functions.

That's good.

> 4. Then I added -finstrument-functions in the configure file (Line number
> 2830) in the extracted httpd-2.4.7 directory, full line below
>   ac_compile=3D'$CC -c $CFLAGS -finstrument-functions $CPPFLAGS
> conftest.$ac_ext >&5'

As Suchakra said, -finstrument-functions is not related. You can use
it later if you want, but let's leave it out for now. Also, if you
want to add compilation flags like this, pass them at configure time.
Also, _never_ change generated files (such as the configure script of
Makefiles). They are way too complicated for a human and will get
overwritten anyway. Instead, you should modify the configure.in or
Makefile.in files, in this case. To add a compilation flag, you could
do:

  $ ./configure CFLAGS=3D"-finstrument-function"

> 5. Then, from the /httpd-2.4.7 directory, I ran the following command to
> configure the installation, it completed without any error.
>     ./configure --libdir=3D/usr/lib/usr/lib/liblttng-ust.so
> --with-included-apr

This is wrong. --libdir is used to tell autotools in which directory
to install the compiled libraries. ./configure --with-included-apr is
sufficient.

> 6. When I ran the command 'make', I get the following error after a while
> ...
> make[1]: Entering directory `/root/httpd-2.4.7'
> /root/httpd-2.4.7/srclib/apr/libtool --silent --mode=3Dcompile gcc -std=
=3Dgnu99
> -g -O2 -pthread      -DLINUX -D_REENTRANT -D_GNU_SOURCE     -I.
> -I/root/httpd-2.4.7/os/unix -I/root/httpd-2.4.7/include
> -I/root/httpd-2.4.7/srclib/apr/include
> -I/root/httpd-2.4.7/srclib/apr-util/include
> -I/root/httpd-2.4.7/srclib/apr-util/xml/expat/lib
> -I/root/httpd-2.4.7/modules/aaa -I/root/httpd-2.4.7/modules/cache
> -I/root/httpd-2.4.7/modules/core -I/root/httpd-2.4.7/modules/database
> -I/root/httpd-2.4.7/modules/filters -I/root/httpd-2.4.7/modules/ldap
> -I/root/httpd-2.4.7/modules/loggers -I/root/httpd-2.4.7/modules/lua
> -I/root/httpd-2.4.7/modules/proxy -I/root/httpd-2.4.7/modules/session
> -I/root/httpd-2.4.7/modules/ssl -I/root/httpd-2.4.7/modules/test
> -I/root/httpd-2.4.7/server -I/root/httpd-2.4.7/modules/arch/unix
> -I/root/httpd-2.4.7/modules/dav/main -I/root/httpd-2.4.7/modules/generato=
rs
> -I/root/httpd-2.4.7/modules/mappers  -prefer-non-pic -static -c modules.c=
 &&
> touch modules.lo
> gcc -std=3Dgnu99  -g -O2 -pthread      -DLINUX -D_REENTRANT -D_GNU_SOURCE
> -I. -I/root/httpd-2.4.7/os/unix -I/root/httpd-2.4.7/include
> -I/root/httpd-2.4.7/srclib/apr/include
> -I/root/httpd-2.4.7/srclib/apr-util/include
> -I/root/httpd-2.4.7/srclib/apr-util/xml/expat/lib
> -I/root/httpd-2.4.7/modules/aaa -I/root/httpd-2.4.7/modules/cache
> -I/root/httpd-2.4.7/modules/core -I/root/httpd-2.4.7/modules/database
> -I/root/httpd-2.4.7/modules/filters -I/root/httpd-2.4.7/modules/ldap
> -I/root/httpd-2.4.7/modules/loggers -I/root/httpd-2.4.7/modules/lua
> -I/root/httpd-2.4.7/modules/proxy -I/root/httpd-2.4.7/modules/session
> -I/root/httpd-2.4.7/modules/ssl -I/root/httpd-2.4.7/modules/test
> -I/root/httpd-2.4.7/server -I/root/httpd-2.4.7/modules/arch/unix
> -I/root/httpd-2.4.7/modules/dav/main -I/root/httpd-2.4.7/modules/generato=
rs
> -I/root/httpd-2.4.7/modules/mappers  -c /root/httpd-2.4.7/server/buildmar=
k.c
> /root/httpd-2.4.7/srclib/apr/libtool --silent --mode=3Dlink gcc -std=3Dgn=
u99  -g
> -O2 -pthread         -o httpd  modules.lo buildmark.o -export-dynamic
> server/libmain.la modules/core/libmod_so.la modules/http/libmod_http.la
> server/mpm/event/libevent.la os/unix/libos.la -L/usr/lib/x86_64-linux-gnu
> -lpcre     /root/httpd-2.4.7/srclib/apr-util/libaprutil-1.la
> /root/httpd-2.4.7/srclib/apr-util/xml/expat/libexpat.la
> /root/httpd-2.4.7/srclib/apr/libapr-1.la -luuid -lrt -lcrypt -lpthread -l=
dl
> server/.libs/libmain.a(main.o): In function `main':
> /root/httpd-2.4.7/server/main.c:443: undefined reference to
> `__tracepoint_mk___apache_process_entry'
> server/.libs/libmain.a(main.o): In function `init_process':
> /root/httpd-2.4.7/server/main.c:284: undefined reference to
> `__tracepoint_mk___apache_process_entry'
> server/.libs/libmain.a(main.o): In function
> `__tracepoint_cb_mk___apache_process_entry':
> /root/httpd-2.4.7/server/smallestTracePoint.h:13: undefined reference to
> `tracepoint_dlopen'
> /root/httpd-2.4.7/server/smallestTracePoint.h:13: undefined reference to
> `__tracepoint_mk___apache_process_entry'
> /root/httpd-2.4.7/server/smallestTracePoint.h:13: undefined reference to
> `tracepoint_dlopen'
> /root/httpd-2.4.7/server/smallestTracePoint.h:13: undefined reference to
> `tracepoint_dlopen'
> /root/httpd-2.4.7/server/smallestTracePoint.h:13: undefined reference to
> `tracepoint_dlopen'
> /root/httpd-2.4.7/server/smallestTracePoint.h:13: undefined reference to
> `__tracepoint_mk___apache_process_entry'
> /root/httpd-2.4.7/server/smallestTracePoint.h:13: undefined reference to
> `tracepoint_dlopen'
> /root/httpd-2.4.7/server/smallestTracePoint.h:13: undefined reference to
> `tracepoint_dlopen'
> collect2: ld returned 1 exit status
> make[1]: *** [httpd] Error 1
> make[1]: Leaving directory `/root/httpd-2.4.7'
> make: *** [all-recursive] Error 1
>
> I have tried including the smallestTracePoint.c file in the local makefile
> (/root/httpd-2.4.7/MakeFile)... didn't do me any good.
> Any idea what I am doing wrong ?

That's right, you have to compile the .c file somewhere. I suggest you
check where main.c is mentionned in a Makefile.in, and add
smallestTracePoint.c there. Don't forget to re-run configure, and try
to make again. This should get rid of the undefined references to
__tracepoint_mk___apache_process_entry. For the other undefined
references, it is because your tracepoint requires additional
libraries, libdl and liblttng-ust. You should then add "-ldl
-llttng-ust" to where the final executable is linked. When inspecting
the build log, we see that this is done by the top-level Makefile, so
we will go edit the top-level Makefile.in.

(there might be a better place to put -ldl -llttng-ust, but it will do for =
now)

Apache should now build with the tracepoint included.

Then, doing

  $ lttng create
  $ lttng enable-event -u -a
  $ lttng start
  $ ./httpd
  (httpd complains about missing config file, but hits the tracepoint anywa=
y)
  $ lttng stop
  $ lttng view
  ...
[08:30:18.522789766] (+0.000173646) simark
apache:apache_process_entry: { cpu_id =3D 2 }, { }
  ...

Yay !

I made a commit here to show the modifications I made to make it work:
https://github.com/simark/httpd/commit/2c6d73c47156350233b346e9eaa49ffb07a5=
8e6e

Hopefully this can help you get started. Iif you instrument apache in
an interesting/useful way, feel free to share your work, it could be
useful for others!

Simon

>
> LTTng version on the instance: 2.4.0-rc2 - =C9poque Opaque
>
> Linux Distribution: Ubuntu 12.04.3 LTS
>
>
> Thanks,
>
>
> --
> Mehran
>
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>
