From: kumar s <skumar.m226@gmail.com>
Subject: liburcu error: Cannot find -lurcu
Date: Fri, 22 Nov 2013 10:51:01 +0530
Message-ID: <CAO_ArvoKDYwE_AwicFH8ebOvxF5-ubK4hZi4QdDDGQns0GXWiQ__37306.9219793708$1385097708$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2055497459=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-la0-f41.google.com ([209.85.215.41])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <skumar.m226@gmail.com>) id 1VjjAy-0003VZ-1R
	for lttng-dev@lists.lttng.org; Fri, 22 Nov 2013 00:21:09 -0500
Received: by mail-la0-f41.google.com with SMTP id eo20so574759lab.28
	for <lttng-dev@lists.lttng.org>; Thu, 21 Nov 2013 21:21:01 -0800 (PST)
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

--===============2055497459==
Content-Type: multipart/alternative; boundary=001a11c3bb341a12d304ebbd2e3f

--001a11c3bb341a12d304ebbd2e3f
Content-Type: text/plain; charset=ISO-8859-1

Hi,

I am using latest version of userspace. Cloned from userspace.git

While Cross Compiling for Mips Architecture I get the following error.

make  all-recursive
make[1]: Entering directory `/home/kumar/userspace/userspace-rcu'
Making all in .
make[2]: Entering directory `/home/kumar/userspace/userspace-rcu'
make[2]: Leaving directory `/home/kumar/userspace/userspace-rcu'
Making all in doc
make[2]: Entering directory `/home/kumar/userspace/userspace-rcu/doc'
Making all in examples
make[3]: Entering directory
`/home/kumar/userspace/userspace-rcu/doc/examples'
make -f dist-files/Makefile AM_CPPFLAGS=" -I../../../urcu/ -I../../../"
AM_CFLAGS='-g -O2' AM_LDFLAGS=' -L../../../.libs/
-Wl,-rpath="/home/kumar/userspace/userspace-rcu/doc/examples/../../.libs/"'
all
make[4]: Entering directory
`/home/kumar/userspace/userspace-rcu/doc/examples'
make -C hlist
make[5]: Entering directory
`/home/kumar/userspace/userspace-rcu/doc/examples/hlist'
make -f Makefile.cds_hlist_add_head_rcu
make[6]: Entering directory
`/home/kumar/userspace/userspace-rcu/doc/examples/hlist'
cc -g -O2 -Wall  -g -O2 -L../../../.libs/
-Wl,-rpath="/home/kumar/userspace/userspace-rcu/doc/examples/../../.libs/" \
        -o cds_hlist_add_head_rcu cds_hlist_add_head_rcu.o -lurcu
/usr/bin/ld: skipping incompatible ../../../.libs//liburcu.so when
searching for -lurcu
/usr/bin/ld: skipping incompatible ../../../.libs//liburcu.a when searching
for -lurcu
/usr/bin/ld: cannot find -lurcu
collect2: ld returned 1 exit status
make[6]: *** [cds_hlist_add_head_rcu] Error 1
make[6]: Leaving directory
`/home/kumar/userspace/userspace-rcu/doc/examples/hlist'
make[5]: *** [all] Error 2
make[5]: Leaving directory
`/home/kumar/userspace/userspace-rcu/doc/examples/hlist'
make[4]: *** [all] Error 2
make[4]: Leaving directory
`/home/kumar/userspace/userspace-rcu/doc/examples'
make[3]: *** [all-local] Error 2
make[3]: Leaving directory
`/home/kumar/userspace/userspace-rcu/doc/examples'
make[2]: *** [all-recursive] Error 1
make[2]: Leaving directory `/home/kumar/userspace/userspace-rcu/doc'
make[1]: *** [all-recursive] Error 1
make[1]: Leaving directory `/home/kumar/userspace/userspace-rcu'
make: *** [all] Error 2


How can i fix this?

Thank you
SKumar

--001a11c3bb341a12d304ebbd2e3f
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div><div>Hi,<br><br></div>I am using latest version =
of userspace. Cloned from userspace.git<br><br></div>While Cross Compiling =
for Mips Architecture I get the following error.<br><br>make=A0 all-recursi=
ve<br>
make[1]: Entering directory `/home/kumar/userspace/userspace-rcu&#39;<br>Ma=
king all in .<br>make[2]: Entering directory `/home/kumar/userspace/userspa=
ce-rcu&#39;<br>make[2]: Leaving directory `/home/kumar/userspace/userspace-=
rcu&#39;<br>
Making all in doc<br>make[2]: Entering directory `/home/kumar/userspace/use=
rspace-rcu/doc&#39;<br>Making all in examples<br>make[3]: Entering director=
y `/home/kumar/userspace/userspace-rcu/doc/examples&#39;<br>make -f dist-fi=
les/Makefile AM_CPPFLAGS=3D&quot; -I../../../urcu/ -I../../../&quot; AM_CFL=
AGS=3D&#39;-g -O2&#39; AM_LDFLAGS=3D&#39; -L../../../.libs/ -Wl,-rpath=3D&q=
uot;/home/kumar/userspace/userspace-rcu/doc/examples/../../.libs/&quot;&#39=
;=A0 all<br>
make[4]: Entering directory `/home/kumar/userspace/userspace-rcu/doc/exampl=
es&#39;<br>make -C hlist<br>make[5]: Entering directory `/home/kumar/usersp=
ace/userspace-rcu/doc/examples/hlist&#39;<br>make -f Makefile.cds_hlist_add=
_head_rcu<br>
make[6]: Entering directory `/home/kumar/userspace/userspace-rcu/doc/exampl=
es/hlist&#39;<br>cc -g -O2 -Wall=A0 -g -O2 -L../../../.libs/ -Wl,-rpath=3D&=
quot;/home/kumar/userspace/userspace-rcu/doc/examples/../../.libs/&quot; \<=
br>
=A0=A0=A0=A0=A0=A0=A0 -o cds_hlist_add_head_rcu cds_hlist_add_head_rcu.o -l=
urcu<br>/usr/bin/ld: skipping incompatible ../../../.libs//liburcu.so when =
searching for -lurcu<br>/usr/bin/ld: skipping incompatible ../../../.libs//=
liburcu.a when searching for -lurcu<br>
/usr/bin/ld: cannot find -lurcu<br>collect2: ld returned 1 exit status<br>m=
ake[6]: *** [cds_hlist_add_head_rcu] Error 1<br>make[6]: Leaving directory =
`/home/kumar/userspace/userspace-rcu/doc/examples/hlist&#39;<br>make[5]: **=
* [all] Error 2<br>
make[5]: Leaving directory `/home/kumar/userspace/userspace-rcu/doc/example=
s/hlist&#39;<br>make[4]: *** [all] Error 2<br>make[4]: Leaving directory `/=
home/kumar/userspace/userspace-rcu/doc/examples&#39;<br>make[3]: *** [all-l=
ocal] Error 2<br>
make[3]: Leaving directory `/home/kumar/userspace/userspace-rcu/doc/example=
s&#39;<br>make[2]: *** [all-recursive] Error 1<br>make[2]: Leaving director=
y `/home/kumar/userspace/userspace-rcu/doc&#39;<br>make[1]: *** [all-recurs=
ive] Error 1<br>
make[1]: Leaving directory `/home/kumar/userspace/userspace-rcu&#39;<br>mak=
e: *** [all] Error 2<br><div><br><br></div><div>How can i fix this?<br></di=
v><br></div><div>Thank you<br></div><div>SKumar<br></div><div><div><br>
</div></div></div>

--001a11c3bb341a12d304ebbd2e3f--


--===============2055497459==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============2055497459==--
