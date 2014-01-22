From: Mehran Khan <i@mehrankhan.com>
Subject: Apache instrumentation for User Space Tracing
Date: Tue, 21 Jan 2014 20:47:09 -0500
Message-ID: <CA+knAy+WSeoKydtxp_HNqSa8ioK_vN6+rtYLqQ5WYtYqKdpaYg__13736.2671703615$1390355310$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0778254771=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from sg2plout10-02.prod.sin2.secureserver.net ([182.50.145.5])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <i@mehrankhan.com>) id 1W5muW-000583-VS
	for lttng-dev@lists.lttng.org; Tue, 21 Jan 2014 20:47:29 -0500
Received: by mail-ee0-f43.google.com with SMTP id c41so4442220eek.2
	for <lttng-dev@lists.lttng.org>; Tue, 21 Jan 2014 17:47:09 -0800 (PST)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

--===============0778254771==
Content-Type: multipart/alternative; boundary=bcaec52996f994aefc04f0854d51

--bcaec52996f994aefc04f0854d51
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable


Hello everyone,
I have been trying to instrument the Apache web server, the latest version
(2.4.7 from the URL http://httpd.apache.org/download.cgi#apache24) for
LTTng UST tracing
1. To start with the simplest case, I created a *.tp file named
*smallestTracePoint.tp* with the content below
    TRACEPOINT_EVENT(
    mk,


    apache_process_entry,
    TP_ARGS(),
    TP_FIELDS()
  )
2. Then I ran the following
   lttng-gen-tp smallestTracePoint.tp -o smallestTracePoint.h -o
smallestTracePoint.c

which generated the files smallestTracePoint.c and smallestTracePoint.h

3. Then, I put the *smallestTracePoint.h* and *smallestTracePoint.c* in
*httpd-2.4.7/server* directory,
included  *smallestTracePoint.h *in the *main.c  *file and added trace
points in the int *main(int argc, const char * const argv[])* and
**init_process(int
*argc, const char * const * *argv)* functions.

4. Then I added *-finstrument-functions* in the *configure* file (Line
number 2830) in the extracted *httpd-2.4.7* directory, full line below
  ac_compile=3D'$CC -c $CFLAGS -finstrument-functions $CPPFLAGS
conftest.$ac_ext >&5'

5. Then, from the /httpd-2.4.7 directory, I ran the following command to
configure the installation, it completed without any error.
    ./configure --libdir=3D/usr/lib/usr/lib/liblttng-ust.so
--with-included-apr

6. When I ran the command 'make', I get the following error after a while
...
make[1]: Entering directory `/root/httpd-2.4.7'
/root/httpd-2.4.7/srclib/apr/libtool --silent --mode=3Dcompile gcc
-std=3Dgnu99  -g -O2 -pthread      -DLINUX -D_REENTRANT -D_GNU_SOURCE     -=
I.
-I/root/httpd-2.4.7/os/unix -I/root/httpd-2.4.7/include
-I/root/httpd-2.4.7/srclib/apr/include
-I/root/httpd-2.4.7/srclib/apr-util/include
-I/root/httpd-2.4.7/srclib/apr-util/xml/expat/lib
-I/root/httpd-2.4.7/modules/aaa -I/root/httpd-2.4.7/modules/cache
-I/root/httpd-2.4.7/modules/core -I/root/httpd-2.4.7/modules/database
-I/root/httpd-2.4.7/modules/filters -I/root/httpd-2.4.7/modules/ldap
-I/root/httpd-2.4.7/modules/loggers -I/root/httpd-2.4.7/modules/lua
-I/root/httpd-2.4.7/modules/proxy -I/root/httpd-2.4.7/modules/session
-I/root/httpd-2.4.7/modules/ssl -I/root/httpd-2.4.7/modules/test
-I/root/httpd-2.4.7/server -I/root/httpd-2.4.7/modules/arch/unix
-I/root/httpd-2.4.7/modules/dav/main -I/root/httpd-2.4.7/modules/generators
-I/root/httpd-2.4.7/modules/mappers  -prefer-non-pic -static -c modules.c
&& touch modules.lo
gcc -std=3Dgnu99  -g -O2 -pthread      -DLINUX -D_REENTRANT -D_GNU_SOURCE
-I. -I/root/httpd-2.4.7/os/unix -I/root/httpd-2.4.7/include
-I/root/httpd-2.4.7/srclib/apr/include
-I/root/httpd-2.4.7/srclib/apr-util/include
-I/root/httpd-2.4.7/srclib/apr-util/xml/expat/lib
-I/root/httpd-2.4.7/modules/aaa -I/root/httpd-2.4.7/modules/cache
-I/root/httpd-2.4.7/modules/core -I/root/httpd-2.4.7/modules/database
-I/root/httpd-2.4.7/modules/filters -I/root/httpd-2.4.7/modules/ldap
-I/root/httpd-2.4.7/modules/loggers -I/root/httpd-2.4.7/modules/lua
-I/root/httpd-2.4.7/modules/proxy -I/root/httpd-2.4.7/modules/session
-I/root/httpd-2.4.7/modules/ssl -I/root/httpd-2.4.7/modules/test
-I/root/httpd-2.4.7/server -I/root/httpd-2.4.7/modules/arch/unix
-I/root/httpd-2.4.7/modules/dav/main -I/root/httpd-2.4.7/modules/generators
-I/root/httpd-2.4.7/modules/mappers  -c /root/httpd-2.4.7/server/buildmark.=
c
/root/httpd-2.4.7/srclib/apr/libtool --silent --mode=3Dlink gcc -std=3Dgnu9=
9
-g -O2 -pthread         -o httpd  modules.lo buildmark.o -export-dynamic
server/libmain.la modules/core/libmod_so.la
modules/http/libmod_http.laserver/mpm/event/
libevent.la os/unix/libos.la -L/usr/lib/x86_64-linux-gnu -lpcre
/root/httpd-2.4.7/srclib/apr-util/libaprutil-1.la/root/httpd-2.4.7/srclib/a=
pr-util/xml/expat/
libexpat.la /root/httpd-2.4.7/srclib/apr/libapr-1.la -luuid -lrt -lcrypt
-lpthread -ldl
server/.libs/libmain.a(main.o): In function `main':
/root/httpd-2.4.7/server/main.c:443: undefined reference to
`__tracepoint_mk___apache_process_entry'
server/.libs/libmain.a(main.o): In function `init_process':
/root/httpd-2.4.7/server/main.c:284: undefined reference to
`__tracepoint_mk___apache_process_entry'
server/.libs/libmain.a(main.o): In function
`__tracepoint_cb_mk___apache_process_entry':
/root/httpd-2.4.7/server/smallestTracePoint.h:13: undefined reference to
`tracepoint_dlopen'
/root/httpd-2.4.7/server/smallestTracePoint.h:13: undefined reference to
`__tracepoint_mk___apache_process_entry'
/root/httpd-2.4.7/server/smallestTracePoint.h:13: undefined reference to
`tracepoint_dlopen'
/root/httpd-2.4.7/server/smallestTracePoint.h:13: undefined reference to
`tracepoint_dlopen'
/root/httpd-2.4.7/server/smallestTracePoint.h:13: undefined reference to
`tracepoint_dlopen'
/root/httpd-2.4.7/server/smallestTracePoint.h:13: undefined reference to
`__tracepoint_mk___apache_process_entry'
/root/httpd-2.4.7/server/smallestTracePoint.h:13: undefined reference to
`tracepoint_dlopen'
/root/httpd-2.4.7/server/smallestTracePoint.h:13: undefined reference to
`tracepoint_dlopen'
collect2: ld returned 1 exit status
make[1]: *** [httpd] Error 1
make[1]: Leaving directory `/root/httpd-2.4.7'
make: *** [all-recursive] Error 1

I have tried including the *smallestTracePoint.c* file in the local
makefile (*/root/httpd-2.4.7/MakeFile)*... didn't do me any good.
Any idea what I am doing wrong ?


LTTng version on the instance: 2.4.0-rc2 - =C9poque Opaque

Linux Distribution: Ubuntu 12.04.3 LTS


Thanks,


--=20
Mehran

--bcaec52996f994aefc04f0854d51
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_default" style=3D"font-family:tahoma,s=
ans-serif;color:rgb(51,51,51)"><div class=3D"gmail_quote"><div dir=3D"ltr">=
<div style=3D"font-family:tahoma,sans-serif;color:rgb(51,51,51)"><div style=
=3D"font-family:tahoma,sans-serif;color:rgb(51,51,51)">
Hello everyone,<br>I have been trying to instrument the Apache web server, =
the latest version (2.4.7 from the URL <a href=3D"http://httpd.apache.org/d=
ownload.cgi#apache24" target=3D"_blank">http://httpd.apache.org/download.cg=
i#apache24</a>) for LTTng UST tracing<br>


1. To start with the simplest case, I created a *.tp file named <i>smallest=
TracePoint.tp</i> with the content below<br>=A0=A0=A0 <span style=3D"font-f=
amily:courier new,monospace">TRACEPOINT_EVENT(<br>=A0=A0=A0 mk,<div class=
=3D"gmail_default" style=3D"font-family:tahoma,sans-serif;color:rgb(51,51,5=
1);display:inline">
</div><br>=A0=A0=A0 apache_process_entry,<br>

=A0=A0=A0 TP_ARGS(),<br>=A0=A0=A0 TP_FIELDS() <br>=A0 )</span><br></div><di=
v style=3D"font-family:tahoma,sans-serif;color:rgb(51,51,51)">2. Then I ran=
 the following <br>=A0=A0 <span style=3D"font-family:courier new,monospace"=
>lttng-gen-tp smallestTracePoint.tp -o smallestTracePoint.h -o smallestTrac=
ePoint.c<br>


</span></div><div style=3D"font-family:tahoma,sans-serif;color:rgb(51,51,51=
)"><span style=3D"font-family:courier new,monospace">=A0 <font face=3D"taho=
ma,sans-serif"><br>which generated the files </font></span><span style=3D"f=
ont-family:courier new,monospace">smallestTracePoint.c <font face=3D"tahoma=
,sans-serif">and </font></span><span style=3D"font-family:courier new,monos=
pace"><font face=3D"tahoma,sans-serif"><span style=3D"font-family:courier n=
ew,monospace">smallestTracePoint.h <br>


<br></span></font></span></div><div style=3D"font-family:tahoma,sans-serif;=
color:rgb(51,51,51)"><span style=3D"font-family:courier new,monospace"><fon=
t face=3D"tahoma,sans-serif"><span style=3D"font-family:courier new,monospa=
ce"><font face=3D"tahoma,sans-serif">3. Then, I put the </font></span></fon=
t></span><span style=3D"font-family:courier new,monospace"><font face=3D"ta=
homa,sans-serif"><span style=3D"font-family:courier new,monospace"><i>small=
estTracePoint.h</i> <span style=3D"font-family:tahoma,sans-serif">and</span=
> </span></font></span><span style=3D"font-family:courier new,monospace"><i=
>smallestTracePoint.c</i> <font face=3D"tahoma,sans-serif">in </font><i>htt=
pd-2.4.7/server</i></span> directory,<br>


</div><div style=3D"font-family:tahoma,sans-serif;color:rgb(51,51,51)">incl=
uded=A0 <span style=3D"font-family:courier new,monospace"><font face=3D"tah=
oma,sans-serif"><span style=3D"font-family:courier new,monospace"><i>smalle=
stTracePoint.h </i><font face=3D"tahoma,sans-serif">in the <i>main.c=A0 </i=
>file and added trace points in </font>the int <i>main(int argc, const char=
 * const argv[])</i> and <i>*init_process(int *argc, const char * const * *=
argv)</i> <span style=3D"font-family:tahoma,sans-serif">functions.</span> <=
br>


<br></span></font></span></div><div style=3D"font-family:tahoma,sans-serif;=
color:rgb(51,51,51)"><span style=3D"font-family:courier new,monospace"><fon=
t face=3D"tahoma,sans-serif"><span style=3D"font-family:courier new,monospa=
ce"><font face=3D"tahoma,sans-serif">4. Then I added <font face=3D"courier =
new,monospace"><i>-finstrument-functions</i><font face=3D"tahoma,sans-serif=
"> </font></font>in the <i>configure</i> file (Line number 2830) in the ext=
racted <i>httpd-2.4.7</i> directory, full line below</font><br>


=A0 ac_compile=3D&#39;$CC -c $CFLAGS -finstrument-functions $CPPFLAGS conft=
est.$ac_ext &gt;&amp;5&#39;<br></span></font></span></div><div style=3D"fon=
t-family:tahoma,sans-serif;color:rgb(51,51,51)">=A0=A0=A0 <br>
</div><div style=3D"font-family:tahoma,sans-serif;color:rgb(51,51,51)">5.=
=20
Then, from the /httpd-2.4.7 directory, I ran the following command to=20
configure the installation, it completed without any error. <br>
=A0=A0=A0<span style=3D"font-family:courier new,monospace"> ./configure --l=
ibdir=3D/usr/lib/usr/lib/liblttng-ust.so --with-included-apr</span><br><br>=
</div><div style=3D"font-family:tahoma,sans-serif;color:rgb(51,51,51)">
6. When I ran the command &#39;make&#39;, I get the following error after a=
 while<br>...<br><span style=3D"font-family:courier new,monospace">make[1]:=
 Entering directory `/root/httpd-2.4.7&#39;<br>/root/httpd-2.4.7/srclib/apr=
/libtool
 --silent --mode=3Dcompile gcc -std=3Dgnu99=A0 -g -O2 -pthread=A0=A0=A0=A0=
=A0 -DLINUX=20
-D_REENTRANT -D_GNU_SOURCE=A0=A0=A0=A0 -I. -I/root/httpd-2.4.7/os/unix=20
-I/root/httpd-2.4.7/include -I/root/httpd-2.4.7/srclib/apr/include -I/root/=
httpd-2.4.7/srclib/apr-util/include -I/root/httpd-2.4.7/srclib/apr-util/xml=
/expat/lib -I/root/httpd-2.4.7/modules/aaa -I/root/httpd-2.4.7/modules/cach=
e -I/root/httpd-2.4.7/modules/core -I/root/httpd-2.4.7/modules/database -I/=
root/httpd-2.4.7/modules/filters -I/root/httpd-2.4.7/modules/ldap -I/root/h=
ttpd-2.4.7/modules/loggers -I/root/httpd-2.4.7/modules/lua -I/root/httpd-2.=
4.7/modules/proxy -I/root/httpd-2.4.7/modules/session -I/root/httpd-2.4.7/m=
odules/ssl -I/root/httpd-2.4.7/modules/test -I/root/httpd-2.4.7/server -I/r=
oot/httpd-2.4.7/modules/arch/unix -I/root/httpd-2.4.7/modules/dav/main -I/r=
oot/httpd-2.4.7/modules/generators -I/root/httpd-2.4.7/modules/mappers=A0 -=
prefer-non-pic -static -c modules.c &amp;&amp; touch modules.lo<br>


gcc -std=3Dgnu99=A0 -g -O2 -pthread=A0=A0=A0=A0=A0 -DLINUX -D_REENTRANT=20
-D_GNU_SOURCE=A0=A0=A0=A0 -I. -I/root/httpd-2.4.7/os/unix=20
-I/root/httpd-2.4.7/include -I/root/httpd-2.4.7/srclib/apr/include -I/root/=
httpd-2.4.7/srclib/apr-util/include -I/root/httpd-2.4.7/srclib/apr-util/xml=
/expat/lib -I/root/httpd-2.4.7/modules/aaa -I/root/httpd-2.4.7/modules/cach=
e -I/root/httpd-2.4.7/modules/core -I/root/httpd-2.4.7/modules/database -I/=
root/httpd-2.4.7/modules/filters -I/root/httpd-2.4.7/modules/ldap -I/root/h=
ttpd-2.4.7/modules/loggers -I/root/httpd-2.4.7/modules/lua -I/root/httpd-2.=
4.7/modules/proxy -I/root/httpd-2.4.7/modules/session -I/root/httpd-2.4.7/m=
odules/ssl -I/root/httpd-2.4.7/modules/test -I/root/httpd-2.4.7/server -I/r=
oot/httpd-2.4.7/modules/arch/unix -I/root/httpd-2.4.7/modules/dav/main -I/r=
oot/httpd-2.4.7/modules/generators -I/root/httpd-2.4.7/modules/mappers=A0 -=
c /root/httpd-2.4.7/server/buildmark.c<br>


/root/httpd-2.4.7/srclib/apr/libtool --silent --mode=3Dlink gcc -std=3Dgnu9=
9=A0 -g -O2 -pthread=A0=A0=A0=A0=A0=A0=A0=A0 -o httpd=A0 modules.lo buildma=
rk.o -export-dynamic server/<a href=3D"http://libmain.la" target=3D"_blank"=
>libmain.la</a> modules/core/<a href=3D"http://libmod_so.la" target=3D"_bla=
nk">libmod_so.la</a> modules/http/<a href=3D"http://libmod_http.la" target=
=3D"_blank">libmod_http.la</a> server/mpm/event/<a href=3D"http://libevent.=
la" target=3D"_blank">libevent.la</a> os/unix/<a href=3D"http://libos.la" t=
arget=3D"_blank">libos.la</a> -L/usr/lib/x86_64-linux-gnu -lpcre=A0=A0=A0=
=A0 /root/httpd-2.4.7/srclib/apr-util/<a href=3D"http://libaprutil-1.la" ta=
rget=3D"_blank">libaprutil-1.la</a> /root/httpd-2.4.7/srclib/apr-util/xml/e=
xpat/<a href=3D"http://libexpat.la" target=3D"_blank">libexpat.la</a> /root=
/httpd-2.4.7/srclib/apr/<a href=3D"http://libapr-1.la" target=3D"_blank">li=
bapr-1.la</a> -luuid -lrt -lcrypt -lpthread -ldl <br>


server/.libs/libmain.a(main.o): In function `main&#39;:<br>/root/httpd-2.4.=
7/server/main.c:443: undefined reference to `__tracepoint_mk___apache_proce=
ss_entry&#39;<br>server/.libs/libmain.a(main.o): In function `init_process&=
#39;:<br>


/root/httpd-2.4.7/server/main.c:284: undefined reference to `__tracepoint_m=
k___apache_process_entry&#39;<br>server/.libs/libmain.a(main.o): In functio=
n `__tracepoint_cb_mk___apache_process_entry&#39;:<br>/root/httpd-2.4.7/ser=
ver/smallestTracePoint.h:13: undefined reference to `tracepoint_dlopen&#39;=
<br>


/root/httpd-2.4.7/server/smallestTracePoint.h:13: undefined reference to `_=
_tracepoint_mk___apache_process_entry&#39;<br>/root/httpd-2.4.7/server/smal=
lestTracePoint.h:13: undefined reference to `tracepoint_dlopen&#39;<br>


/root/httpd-2.4.7/server/smallestTracePoint.h:13: undefined reference to `t=
racepoint_dlopen&#39;<br>/root/httpd-2.4.7/server/smallestTracePoint.h:13: =
undefined reference to `tracepoint_dlopen&#39;<br>/root/httpd-2.4.7/server/=
smallestTracePoint.h:13: undefined reference to `__tracepoint_mk___apache_p=
rocess_entry&#39;<br>


/root/httpd-2.4.7/server/smallestTracePoint.h:13: undefined reference to `t=
racepoint_dlopen&#39;<br>/root/httpd-2.4.7/server/smallestTracePoint.h:13: =
undefined reference to `tracepoint_dlopen&#39;<br>collect2: ld returned 1 e=
xit status<br>


make[1]: *** [httpd] Error 1<br>make[1]: Leaving directory `/root/httpd-2.4=
.7&#39;<br>make: *** [all-recursive] Error 1</span><br><br>I have tried inc=
luding the <i>smallestTracePoint.c</i> file in the local makefile (<i>/root=
/httpd-2.4.7/MakeFile)</i>... didn&#39;t do me any good.<br>



</div>Any idea what I am doing wrong ?</div><br><br><div style=3D"font-fami=
ly:tahoma,sans-serif;color:rgb(51,51,51);display:inline">LTTng version on t=
he instance: 2.4.0-rc2 - =C9poque Opaque</div><br>
<div style=3D"font-family:tahoma,sans-serif;color:rgb(51,51,51);display:inl=
ine">Linux Distribution: Ubuntu 12.04.3 LTS</div><br><br><div style=3D"font=
-family:tahoma,sans-serif;color:rgb(51,51,51);display:inline">
Thanks,</div><span><font color=3D"#888888"><br><br>-- <br><div dir=3D"ltr">=
<div style=3D"font-family:tahoma,sans-serif;color:rgb(51,51,51)">Mehran</di=
v><br></div></font></span></div></div></div>
</div>

--bcaec52996f994aefc04f0854d51--


--===============0778254771==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0778254771==--
