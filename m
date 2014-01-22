From: Mehran Khan <i@mehrankhan.com>
Subject: Re: (no subject)
Date: Wed, 22 Jan 2014 15:01:09 -0500
Message-ID: <CA+knAyLBTu5K5ekPax6FnY5Jw9Eg3QScVgQwwDS9xRzK6q9t7w__24790.0085211315$1390420952$gmane$org@mail.gmail.com>
References: <CA+knAyLjni_imS1h=+==+Gqax9ZAQu0k5Wxi0ztjph_J=LZJWw@mail.gmail.com>
	<CAFXXi0=xW=2CKSgcJuRZCx3MzTE-_gtxEm+kM+cM1LFWcHu=Wg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0245224478=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from sg2plout10-02.prod.sin2.secureserver.net ([182.50.145.5])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <i@mehrankhan.com>) id 1W63zF-0005Xz-Ll
	for lttng-dev@lists.lttng.org; Wed, 22 Jan 2014 15:01:29 -0500
Received: by mail-bk0-f50.google.com with SMTP id w16so40484bkz.37
	for <lttng-dev@lists.lttng.org>; Wed, 22 Jan 2014 12:01:10 -0800 (PST)
In-Reply-To: <CAFXXi0=xW=2CKSgcJuRZCx3MzTE-_gtxEm+kM+cM1LFWcHu=Wg@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============0245224478==
Content-Type: multipart/alternative; boundary=001a113300200c1fc304f094968a

--001a113300200c1fc304f094968a
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hello Simon,
it did solve my problem. Cannot thank you enough!
I will share my work once I get to any interesting point.

Thank you again,
Mehran


On Wed, Jan 22, 2014 at 8:39 AM, Simon Marchi <simon.marchi@polymtl.ca>wrot=
e:

> Hi Mehran,
>
> I'll try to correct you where I can.
>
> On 21 January 2014 18:34, Mehran Khan <i@mehrankhan.com> wrote:
> > Hello everyone,
> > I have been trying to instrument the Apache web server, the latest
> version
> > (2.4.7 from the URL http://httpd.apache.org/download.cgi#apache24) for
> LTTng
> > UST tracing
> > 1. To start with the simplest case, I created a *.tp file named
> > smallestTracePoint.tp with the content below
> >     TRACEPOINT_EVENT(
> >     mk,
> >     apache_process_entry,
> >     TP_ARGS(),
> >     TP_FIELDS()
> >   )
>
> This is good.
>
> > 2. Then I ran the following
> >    lttng-gen-tp smallestTracePoint.tp -o smallestTracePoint.h -o
> > smallestTracePoint.c
> >
> > which generated the files smallestTracePoint.c and smallestTracePoint.h
>
> You can just say
>   $ lttng-gen-tp smallestTracePoint.tp
> and it will generate the .h and .c.
>
> > 3. Then, I put the smallestTracePoint.h and smallestTracePoint.c in
> > httpd-2.4.7/server directory,
> > included  smallestTracePoint.h in the main.c  file and added trace
> points in
> > the int main(int argc, const char * const argv[]) and *init_process(int
> > *argc, const char * const * *argv) functions.
>
> That's good.
>
> > 4. Then I added -finstrument-functions in the configure file (Line numb=
er
> > 2830) in the extracted httpd-2.4.7 directory, full line below
> >   ac_compile=3D'$CC -c $CFLAGS -finstrument-functions $CPPFLAGS
> > conftest.$ac_ext >&5'
>
> As Suchakra said, -finstrument-functions is not related. You can use
> it later if you want, but let's leave it out for now. Also, if you
> want to add compilation flags like this, pass them at configure time.
> Also, _never_ change generated files (such as the configure script of
> Makefiles). They are way too complicated for a human and will get
> overwritten anyway. Instead, you should modify the configure.in or
> Makefile.in files, in this case. To add a compilation flag, you could
> do:
>
>   $ ./configure CFLAGS=3D"-finstrument-function"
>
> > 5. Then, from the /httpd-2.4.7 directory, I ran the following command t=
o
> > configure the installation, it completed without any error.
> >     ./configure --libdir=3D/usr/lib/usr/lib/liblttng-ust.so
> > --with-included-apr
>
> This is wrong. --libdir is used to tell autotools in which directory
> to install the compiled libraries. ./configure --with-included-apr is
> sufficient.
>
> > 6. When I ran the command 'make', I get the following error after a whi=
le
> > ...
> > make[1]: Entering directory `/root/httpd-2.4.7'
> > /root/httpd-2.4.7/srclib/apr/libtool --silent --mode=3Dcompile gcc
> -std=3Dgnu99
> > -g -O2 -pthread      -DLINUX -D_REENTRANT -D_GNU_SOURCE     -I.
> > -I/root/httpd-2.4.7/os/unix -I/root/httpd-2.4.7/include
> > -I/root/httpd-2.4.7/srclib/apr/include
> > -I/root/httpd-2.4.7/srclib/apr-util/include
> > -I/root/httpd-2.4.7/srclib/apr-util/xml/expat/lib
> > -I/root/httpd-2.4.7/modules/aaa -I/root/httpd-2.4.7/modules/cache
> > -I/root/httpd-2.4.7/modules/core -I/root/httpd-2.4.7/modules/database
> > -I/root/httpd-2.4.7/modules/filters -I/root/httpd-2.4.7/modules/ldap
> > -I/root/httpd-2.4.7/modules/loggers -I/root/httpd-2.4.7/modules/lua
> > -I/root/httpd-2.4.7/modules/proxy -I/root/httpd-2.4.7/modules/session
> > -I/root/httpd-2.4.7/modules/ssl -I/root/httpd-2.4.7/modules/test
> > -I/root/httpd-2.4.7/server -I/root/httpd-2.4.7/modules/arch/unix
> > -I/root/httpd-2.4.7/modules/dav/main
> -I/root/httpd-2.4.7/modules/generators
> > -I/root/httpd-2.4.7/modules/mappers  -prefer-non-pic -static -c
> modules.c &&
> > touch modules.lo
> > gcc -std=3Dgnu99  -g -O2 -pthread      -DLINUX -D_REENTRANT -D_GNU_SOUR=
CE
> > -I. -I/root/httpd-2.4.7/os/unix -I/root/httpd-2.4.7/include
> > -I/root/httpd-2.4.7/srclib/apr/include
> > -I/root/httpd-2.4.7/srclib/apr-util/include
> > -I/root/httpd-2.4.7/srclib/apr-util/xml/expat/lib
> > -I/root/httpd-2.4.7/modules/aaa -I/root/httpd-2.4.7/modules/cache
> > -I/root/httpd-2.4.7/modules/core -I/root/httpd-2.4.7/modules/database
> > -I/root/httpd-2.4.7/modules/filters -I/root/httpd-2.4.7/modules/ldap
> > -I/root/httpd-2.4.7/modules/loggers -I/root/httpd-2.4.7/modules/lua
> > -I/root/httpd-2.4.7/modules/proxy -I/root/httpd-2.4.7/modules/session
> > -I/root/httpd-2.4.7/modules/ssl -I/root/httpd-2.4.7/modules/test
> > -I/root/httpd-2.4.7/server -I/root/httpd-2.4.7/modules/arch/unix
> > -I/root/httpd-2.4.7/modules/dav/main
> -I/root/httpd-2.4.7/modules/generators
> > -I/root/httpd-2.4.7/modules/mappers  -c
> /root/httpd-2.4.7/server/buildmark.c
> > /root/httpd-2.4.7/srclib/apr/libtool --silent --mode=3Dlink gcc -std=3D=
gnu99
>  -g
> > -O2 -pthread         -o httpd  modules.lo buildmark.o -export-dynamic
> > server/libmain.la modules/core/libmod_so.la modules/http/libmod_http.la
> > server/mpm/event/libevent.la os/unix/libos.la-L/usr/lib/x86_64-linux-gn=
u
> > -lpcre     /root/httpd-2.4.7/srclib/apr-util/libaprutil-1.la
> > /root/httpd-2.4.7/srclib/apr-util/xml/expat/libexpat.la
> > /root/httpd-2.4.7/srclib/apr/libapr-1.la -luuid -lrt -lcrypt -lpthread
> -ldl
> > server/.libs/libmain.a(main.o): In function `main':
> > /root/httpd-2.4.7/server/main.c:443: undefined reference to
> > `__tracepoint_mk___apache_process_entry'
> > server/.libs/libmain.a(main.o): In function `init_process':
> > /root/httpd-2.4.7/server/main.c:284: undefined reference to
> > `__tracepoint_mk___apache_process_entry'
> > server/.libs/libmain.a(main.o): In function
> > `__tracepoint_cb_mk___apache_process_entry':
> > /root/httpd-2.4.7/server/smallestTracePoint.h:13: undefined reference t=
o
> > `tracepoint_dlopen'
> > /root/httpd-2.4.7/server/smallestTracePoint.h:13: undefined reference t=
o
> > `__tracepoint_mk___apache_process_entry'
> > /root/httpd-2.4.7/server/smallestTracePoint.h:13: undefined reference t=
o
> > `tracepoint_dlopen'
> > /root/httpd-2.4.7/server/smallestTracePoint.h:13: undefined reference t=
o
> > `tracepoint_dlopen'
> > /root/httpd-2.4.7/server/smallestTracePoint.h:13: undefined reference t=
o
> > `tracepoint_dlopen'
> > /root/httpd-2.4.7/server/smallestTracePoint.h:13: undefined reference t=
o
> > `__tracepoint_mk___apache_process_entry'
> > /root/httpd-2.4.7/server/smallestTracePoint.h:13: undefined reference t=
o
> > `tracepoint_dlopen'
> > /root/httpd-2.4.7/server/smallestTracePoint.h:13: undefined reference t=
o
> > `tracepoint_dlopen'
> > collect2: ld returned 1 exit status
> > make[1]: *** [httpd] Error 1
> > make[1]: Leaving directory `/root/httpd-2.4.7'
> > make: *** [all-recursive] Error 1
> >
> > I have tried including the smallestTracePoint.c file in the local
> makefile
> > (/root/httpd-2.4.7/MakeFile)... didn't do me any good.
> > Any idea what I am doing wrong ?
>
> That's right, you have to compile the .c file somewhere. I suggest you
> check where main.c is mentionned in a Makefile.in, and add
> smallestTracePoint.c there. Don't forget to re-run configure, and try
> to make again. This should get rid of the undefined references to
> __tracepoint_mk___apache_process_entry. For the other undefined
> references, it is because your tracepoint requires additional
> libraries, libdl and liblttng-ust. You should then add "-ldl
> -llttng-ust" to where the final executable is linked. When inspecting
> the build log, we see that this is done by the top-level Makefile, so
> we will go edit the top-level Makefile.in.
>
> (there might be a better place to put -ldl -llttng-ust, but it will do fo=
r
> now)
>
> Apache should now build with the tracepoint included.
>
> Then, doing
>
>   $ lttng create
>   $ lttng enable-event -u -a
>   $ lttng start
>   $ ./httpd
>   (httpd complains about missing config file, but hits the tracepoint
> anyway)
>   $ lttng stop
>   $ lttng view
>   ...
> [08:30:18.522789766] (+0.000173646) simark
> apache:apache_process_entry: { cpu_id =3D 2 }, { }
>   ...
>
> Yay !
>
> I made a commit here to show the modifications I made to make it work:
>
> https://github.com/simark/httpd/commit/2c6d73c47156350233b346e9eaa49ffb07=
a58e6e
>
> Hopefully this can help you get started. Iif you instrument apache in
> an interesting/useful way, feel free to share your work, it could be
> useful for others!
>
> Simon
>
> >
> > LTTng version on the instance: 2.4.0-rc2 - =C9poque Opaque
> >
> > Linux Distribution: Ubuntu 12.04.3 LTS
> >
> >
> > Thanks,
> >
> >
> > --
> > Mehran
> >
> >
> > _______________________________________________
> > lttng-dev mailing list
> > lttng-dev@lists.lttng.org
> > http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> >
>



--=20
-M.K.

--001a113300200c1fc304f094968a
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_default" style=3D"font-family:tahoma,s=
ans-serif;color:rgb(51,51,51)"><div class=3D"gmail_default" style=3D"font-f=
amily:tahoma,sans-serif;color:rgb(51,51,51)">Hello Simon,<br></div><div cla=
ss=3D"gmail_default" style=3D"font-family:tahoma,sans-serif;color:rgb(51,51=
,51)">
it did solve my problem. Cannot thank you enough!<br>
</div><div class=3D"gmail_default" style=3D"font-family:tahoma,sans-serif;c=
olor:rgb(51,51,51)">I will share my work once I get to any interesting poin=
t.<br><br></div><div class=3D"gmail_default" style=3D"font-family:tahoma,sa=
ns-serif;color:rgb(51,51,51)">

Thank you again,<br></div>Mehran</div></div><div class=3D"gmail_extra"><br>=
<br><div class=3D"gmail_quote">On Wed, Jan 22, 2014 at 8:39 AM, Simon March=
i <span dir=3D"ltr">&lt;<a href=3D"mailto:simon.marchi@polymtl.ca" target=
=3D"_blank">simon.marchi@polymtl.ca</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">Hi Mehran,<br>
<br>
I&#39;ll try to correct you where I can.<br>
<br>
On 21 January 2014 18:34, Mehran Khan &lt;<a href=3D"mailto:i@mehrankhan.co=
m">i@mehrankhan.com</a>&gt; wrote:<br>
&gt; Hello everyone,<br>
&gt; I have been trying to instrument the Apache web server, the latest ver=
sion<br>
&gt; (2.4.7 from the URL <a href=3D"http://httpd.apache.org/download.cgi#ap=
ache24" target=3D"_blank">http://httpd.apache.org/download.cgi#apache24</a>=
) for LTTng<br>
&gt; UST tracing<br>
&gt; 1. To start with the simplest case, I created a *.tp file named<br>
&gt; smallestTracePoint.tp with the content below<br>
&gt; =A0 =A0 TRACEPOINT_EVENT(<br>
&gt; =A0 =A0 mk,<br>
&gt; =A0 =A0 apache_process_entry,<br>
&gt; =A0 =A0 TP_ARGS(),<br>
&gt; =A0 =A0 TP_FIELDS()<br>
&gt; =A0 )<br>
<br>
This is good.<br>
<br>
&gt; 2. Then I ran the following<br>
&gt; =A0 =A0lttng-gen-tp smallestTracePoint.tp -o smallestTracePoint.h -o<b=
r>
&gt; smallestTracePoint.c<br>
&gt;<br>
&gt; which generated the files smallestTracePoint.c and smallestTracePoint.=
h<br>
<br>
You can just say<br>
=A0 $ lttng-gen-tp smallestTracePoint.tp<br>
and it will generate the .h and .c.<br>
<br>
&gt; 3. Then, I put the smallestTracePoint.h and smallestTracePoint.c in<br=
>
&gt; httpd-2.4.7/server directory,<br>
&gt; included =A0smallestTracePoint.h in the main.c =A0file and added trace=
 points in<br>
&gt; the int main(int argc, const char * const argv[]) and *init_process(in=
t<br>
&gt; *argc, const char * const * *argv) functions.<br>
<br>
That&#39;s good.<br>
<br>
&gt; 4. Then I added -finstrument-functions in the configure file (Line num=
ber<br>
&gt; 2830) in the extracted httpd-2.4.7 directory, full line below<br>
<div class=3D"im">&gt; =A0 ac_compile=3D&#39;$CC -c $CFLAGS -finstrument-fu=
nctions $CPPFLAGS<br>
&gt; conftest.$ac_ext &gt;&amp;5&#39;<br>
<br>
</div>As Suchakra said, -finstrument-functions is not related. You can use<=
br>
it later if you want, but let&#39;s leave it out for now. Also, if you<br>
want to add compilation flags like this, pass them at configure time.<br>
Also, _never_ change generated files (such as the configure script of<br>
Makefiles). They are way too complicated for a human and will get<br>
overwritten anyway. Instead, you should modify the <a href=3D"http://config=
ure.in" target=3D"_blank">configure.in</a> or<br>
Makefile.in files, in this case. To add a compilation flag, you could<br>
do:<br>
<br>
=A0 $ ./configure CFLAGS=3D&quot;-finstrument-function&quot;<br>
<div class=3D"im"><br>
&gt; 5. Then, from the /httpd-2.4.7 directory, I ran the following command =
to<br>
&gt; configure the installation, it completed without any error.<br>
&gt; =A0 =A0 ./configure --libdir=3D/usr/lib/usr/lib/liblttng-ust.so<br>
&gt; --with-included-apr<br>
<br>
</div>This is wrong. --libdir is used to tell autotools in which directory<=
br>
to install the compiled libraries. ./configure --with-included-apr is<br>
sufficient.<br>
<div class=3D"im"><br>
&gt; 6. When I ran the command &#39;make&#39;, I get the following error af=
ter a while<br>
&gt; ...<br>
&gt; make[1]: Entering directory `/root/httpd-2.4.7&#39;<br>
</div>&gt; /root/httpd-2.4.7/srclib/apr/libtool --silent --mode=3Dcompile g=
cc -std=3Dgnu99<br>
&gt; -g -O2 -pthread =A0 =A0 =A0-DLINUX -D_REENTRANT -D_GNU_SOURCE =A0 =A0 =
-I.<br>
&gt; -I/root/httpd-2.4.7/os/unix -I/root/httpd-2.4.7/include<br>
&gt; -I/root/httpd-2.4.7/srclib/apr/include<br>
&gt; -I/root/httpd-2.4.7/srclib/apr-util/include<br>
&gt; -I/root/httpd-2.4.7/srclib/apr-util/xml/expat/lib<br>
&gt; -I/root/httpd-2.4.7/modules/aaa -I/root/httpd-2.4.7/modules/cache<br>
&gt; -I/root/httpd-2.4.7/modules/core -I/root/httpd-2.4.7/modules/database<=
br>
&gt; -I/root/httpd-2.4.7/modules/filters -I/root/httpd-2.4.7/modules/ldap<b=
r>
&gt; -I/root/httpd-2.4.7/modules/loggers -I/root/httpd-2.4.7/modules/lua<br=
>
&gt; -I/root/httpd-2.4.7/modules/proxy -I/root/httpd-2.4.7/modules/session<=
br>
&gt; -I/root/httpd-2.4.7/modules/ssl -I/root/httpd-2.4.7/modules/test<br>
&gt; -I/root/httpd-2.4.7/server -I/root/httpd-2.4.7/modules/arch/unix<br>
&gt; -I/root/httpd-2.4.7/modules/dav/main -I/root/httpd-2.4.7/modules/gener=
ators<br>
&gt; -I/root/httpd-2.4.7/modules/mappers =A0-prefer-non-pic -static -c modu=
les.c &amp;&amp;<br>
&gt; touch modules.lo<br>
&gt; gcc -std=3Dgnu99 =A0-g -O2 -pthread =A0 =A0 =A0-DLINUX -D_REENTRANT -D=
_GNU_SOURCE<br>
&gt; -I. -I/root/httpd-2.4.7/os/unix -I/root/httpd-2.4.7/include<br>
&gt; -I/root/httpd-2.4.7/srclib/apr/include<br>
&gt; -I/root/httpd-2.4.7/srclib/apr-util/include<br>
&gt; -I/root/httpd-2.4.7/srclib/apr-util/xml/expat/lib<br>
&gt; -I/root/httpd-2.4.7/modules/aaa -I/root/httpd-2.4.7/modules/cache<br>
&gt; -I/root/httpd-2.4.7/modules/core -I/root/httpd-2.4.7/modules/database<=
br>
&gt; -I/root/httpd-2.4.7/modules/filters -I/root/httpd-2.4.7/modules/ldap<b=
r>
&gt; -I/root/httpd-2.4.7/modules/loggers -I/root/httpd-2.4.7/modules/lua<br=
>
&gt; -I/root/httpd-2.4.7/modules/proxy -I/root/httpd-2.4.7/modules/session<=
br>
&gt; -I/root/httpd-2.4.7/modules/ssl -I/root/httpd-2.4.7/modules/test<br>
&gt; -I/root/httpd-2.4.7/server -I/root/httpd-2.4.7/modules/arch/unix<br>
&gt; -I/root/httpd-2.4.7/modules/dav/main -I/root/httpd-2.4.7/modules/gener=
ators<br>
&gt; -I/root/httpd-2.4.7/modules/mappers =A0-c /root/httpd-2.4.7/server/bui=
ldmark.c<br>
<div class=3D"im">&gt; /root/httpd-2.4.7/srclib/apr/libtool --silent --mode=
=3Dlink gcc -std=3Dgnu99 =A0-g<br>
&gt; -O2 -pthread =A0 =A0 =A0 =A0 -o httpd =A0modules.lo buildmark.o -expor=
t-dynamic<br>
</div>&gt; server/<a href=3D"http://libmain.la" target=3D"_blank">libmain.l=
a</a> modules/core/<a href=3D"http://libmod_so.la" target=3D"_blank">libmod=
_so.la</a> modules/http/<a href=3D"http://libmod_http.la" target=3D"_blank"=
>libmod_http.la</a><br>

&gt; server/mpm/event/<a href=3D"http://libevent.la" target=3D"_blank">libe=
vent.la</a> os/unix/<a href=3D"http://libos.la" target=3D"_blank">libos.la<=
/a> -L/usr/lib/x86_64-linux-gnu<br>
&gt; -lpcre =A0 =A0 /root/httpd-2.4.7/srclib/apr-util/<a href=3D"http://lib=
aprutil-1.la" target=3D"_blank">libaprutil-1.la</a><br>
<div class=3D"im">&gt; /root/httpd-2.4.7/srclib/apr-util/xml/expat/<a href=
=3D"http://libexpat.la" target=3D"_blank">libexpat.la</a><br>
&gt; /root/httpd-2.4.7/srclib/apr/<a href=3D"http://libapr-1.la" target=3D"=
_blank">libapr-1.la</a> -luuid -lrt -lcrypt -lpthread -ldl<br>
</div>&gt; server/.libs/libmain.a(main.o): In function `main&#39;:<br>
&gt; /root/httpd-2.4.7/server/main.c:443: undefined reference to<br>
&gt; `__tracepoint_mk___apache_process_entry&#39;<br>
&gt; server/.libs/libmain.a(main.o): In function `init_process&#39;:<br>
&gt; /root/httpd-2.4.7/server/main.c:284: undefined reference to<br>
&gt; `__tracepoint_mk___apache_process_entry&#39;<br>
&gt; server/.libs/libmain.a(main.o): In function<br>
&gt; `__tracepoint_cb_mk___apache_process_entry&#39;:<br>
&gt; /root/httpd-2.4.7/server/smallestTracePoint.h:13: undefined reference =
to<br>
&gt; `tracepoint_dlopen&#39;<br>
&gt; /root/httpd-2.4.7/server/smallestTracePoint.h:13: undefined reference =
to<br>
&gt; `__tracepoint_mk___apache_process_entry&#39;<br>
&gt; /root/httpd-2.4.7/server/smallestTracePoint.h:13: undefined reference =
to<br>
&gt; `tracepoint_dlopen&#39;<br>
&gt; /root/httpd-2.4.7/server/smallestTracePoint.h:13: undefined reference =
to<br>
&gt; `tracepoint_dlopen&#39;<br>
&gt; /root/httpd-2.4.7/server/smallestTracePoint.h:13: undefined reference =
to<br>
&gt; `tracepoint_dlopen&#39;<br>
&gt; /root/httpd-2.4.7/server/smallestTracePoint.h:13: undefined reference =
to<br>
&gt; `__tracepoint_mk___apache_process_entry&#39;<br>
&gt; /root/httpd-2.4.7/server/smallestTracePoint.h:13: undefined reference =
to<br>
&gt; `tracepoint_dlopen&#39;<br>
&gt; /root/httpd-2.4.7/server/smallestTracePoint.h:13: undefined reference =
to<br>
&gt; `tracepoint_dlopen&#39;<br>
&gt; collect2: ld returned 1 exit status<br>
&gt; make[1]: *** [httpd] Error 1<br>
&gt; make[1]: Leaving directory `/root/httpd-2.4.7&#39;<br>
&gt; make: *** [all-recursive] Error 1<br>
&gt;<br>
&gt; I have tried including the smallestTracePoint.c file in the local make=
file<br>
&gt; (/root/httpd-2.4.7/MakeFile)... didn&#39;t do me any good.<br>
<div class=3D"im">&gt; Any idea what I am doing wrong ?<br>
<br>
</div>That&#39;s right, you have to compile the .c file somewhere. I sugges=
t you<br>
check where main.c is mentionned in a Makefile.in, and add<br>
smallestTracePoint.c there. Don&#39;t forget to re-run configure, and try<b=
r>
to make again. This should get rid of the undefined references to<br>
__tracepoint_mk___apache_process_entry. For the other undefined<br>
references, it is because your tracepoint requires additional<br>
libraries, libdl and liblttng-ust. You should then add &quot;-ldl<br>
-llttng-ust&quot; to where the final executable is linked. When inspecting<=
br>
the build log, we see that this is done by the top-level Makefile, so<br>
we will go edit the top-level Makefile.in.<br>
<br>
(there might be a better place to put -ldl -llttng-ust, but it will do for =
now)<br>
<br>
Apache should now build with the tracepoint included.<br>
<br>
Then, doing<br>
<br>
=A0 $ lttng create<br>
=A0 $ lttng enable-event -u -a<br>
=A0 $ lttng start<br>
=A0 $ ./httpd<br>
=A0 (httpd complains about missing config file, but hits the tracepoint any=
way)<br>
=A0 $ lttng stop<br>
=A0 $ lttng view<br>
=A0 ...<br>
[08:30:18.522789766] (+0.000173646) simark<br>
apache:apache_process_entry: { cpu_id =3D 2 }, { }<br>
=A0 ...<br>
<br>
Yay !<br>
<br>
I made a commit here to show the modifications I made to make it work:<br>
<a href=3D"https://github.com/simark/httpd/commit/2c6d73c47156350233b346e9e=
aa49ffb07a58e6e" target=3D"_blank">https://github.com/simark/httpd/commit/2=
c6d73c47156350233b346e9eaa49ffb07a58e6e</a><br>
<br>
Hopefully this can help you get started. Iif you instrument apache in<br>
an interesting/useful way, feel free to share your work, it could be<br>
useful for others!<br>
<br>
Simon<br>
<br>
&gt;<br>
&gt; LTTng version on the instance: 2.4.0-rc2 - =C9poque Opaque<br>
&gt;<br>
&gt; Linux Distribution: Ubuntu 12.04.3 LTS<br>
&gt;<br>
&gt;<br>
&gt; Thanks,<br>
&gt;<br>
<span class=3D"HOEnZb"><font color=3D"#888888">&gt;<br>
&gt; --<br>
&gt; Mehran<br>
&gt;<br>
&gt;<br>
&gt; _______________________________________________<br>
&gt; lttng-dev mailing list<br>
&gt; <a href=3D"mailto:lttng-dev@lists.lttng.org">lttng-dev@lists.lttng.org=
</a><br>
&gt; <a href=3D"http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev" =
target=3D"_blank">http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev=
</a><br>
&gt;<br>
</font></span></blockquote></div><br><br clear=3D"all"><br>-- <br><div dir=
=3D"ltr">-M.K.<br></div>
</div>

--001a113300200c1fc304f094968a--


--===============0245224478==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0245224478==--
