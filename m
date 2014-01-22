From: Suchakrapani Datt Sharma <suchakrapani.sharma@polymtl.ca>
Subject: Re: (no subject)
Date: Tue, 21 Jan 2014 21:30:01 -0500
Message-ID: <1390357801.52df2d29462e4__23228.0393167914$1390357866$gmane$org@www.imp.polymtl.ca>
References: <CA+knAyLjni_imS1h=+==+Gqax9ZAQu0k5Wxi0ztjph_J=LZJWw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.polymtl.ca ([132.207.4.11])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <suchakrapani.sharma@polymtl.ca>) id 1W5nZq-0005Ts-ET
	for lttng-dev@lists.lttng.org; Tue, 21 Jan 2014 21:30:08 -0500
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
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Hi,

I did not try to look into httpd as you require but here are some pointers.

Quoting Mehran Khan <i@mehrankhan.com>:

---------------- SNIP ------------------
>
> 3. Then, I put the *smallestTracePoint.h* and *smallestTracePoint.c* in
> *httpd-2.4.7/server* directory,
> included  *smallestTracePoint.h *in the *main.c  *file and added trace
> points in the int *main(int argc, const char * const argv[])* and
> **init_process(int
> *argc, const char * const * *argv)* functions.

Did you do a #define TRACEPOINT_DEFINE in main.c and also include your
smallestTracePoint.h?

> 4. Then I added *-finstrument-functions* in the *configure* file (Line
> number 2830) in the extracted *httpd-2.4.7* directory, full line below
>   ac_compile='$CC -c $CFLAGS -finstrument-functions $CPPFLAGS
> conftest.$ac_ext >&5'

I do not know why -finstrument-functions is required here. Its independent of
lttng tracepoints afaik.

> 5. Then, from the /httpd-2.4.7 directory, I ran the following command to
> configure the installation, it completed without any error.
>     ./configure --libdir=/usr/lib/usr/lib/liblttng-ust.so
> --with-included-apr

Why not export LDFLAGS='-llttng-ust' before configure or maybe add it in the
Makefile/Makefile.in whatever httpd uses.

> 6. When I ran the command 'make', I get the following error after a while
> ...
> make[1]: Entering directory `/root/httpd-2.4.7'
> /root/httpd-2.4.7/srclib/apr/libtool --silent --mode=compile gcc

---------------- SNIP ------------------

> /root/httpd-2.4.7/srclib/apr/libtool --silent --mode=link gcc -std=gnu99
> -g -O2 -pthread         -o httpd  modules.lo buildmark.o -export-dynamic
> server/libmain.la modules/core/libmod_so.la
> modules/http/libmod_http.laserver/mpm/event/
> libevent.la os/unix/libos.la -L/usr/lib/x86_64-linux-gnu -lpcre
>
/root/httpd-2.4.7/srclib/apr-util/libaprutil-1.la/root/httpd-2.4.7/srclib/apr-util/xml/expat/
> libexpat.la /root/httpd-2.4.7/srclib/apr/libapr-1.la -luuid -lrt -lcrypt
> -lpthread -ldl

I can't see -llttng-ust in the build command.

> I have tried including the *smallestTracePoint.c* file in the local
> makefile (*/root/httpd-2.4.7/MakeFile)*... didn't do me any good.
> Any idea what I am doing wrong ?

You definitely need to include this in the build but I don't think an auto
generated Makefile is a good place.

For your convenience, I instrumented thttpd here [1]. Its a tiny and fast web
server. There is 1 tracepoint in handle_newconnect() Have a look at
Makefile.in, thttpd_tp.c and thttpd_tp_provider.h

If you want generated traces, do let me know.

[1] http://suchakra.fedorapeople.org/lttng/thttpd-instrumented.tar.gz

--
Suchakra
