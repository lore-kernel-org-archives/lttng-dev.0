From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: make lttng-ust
Date: Tue, 7 May 2013 09:22:10 -0400
Message-ID: <20130507132210.GG4186__14329.5919675895$1367932963$gmane$org@Krystal>
References: <48CF5AC71E61DB46B70D0F388054EFFD025F4E@VAL-E-01.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1UZhqP-0001fa-2X
	for lttng-dev@lists.lttng.org; Tue, 07 May 2013 09:22:13 -0400
Content-Disposition: inline
In-Reply-To: <48CF5AC71E61DB46B70D0F388054EFFD025F4E@VAL-E-01.valcartier.drdc-rddc.gc.ca>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>, "Couture,
	Mario" <Mario.Couture@drdc-rddc.gc.ca>, "Painchaud,
	Frederic" <Frederic.Painchaud@drdc-rddc.gc.ca>
List-Id: lttng-dev@lists.lttng.org

* Thibault, Daniel (Daniel.Thibault@drdc-rddc.gc.ca) wrote:
>    The last few times I rebuilt the lttng-ust package, make's log contain=
s some ominous complaints, although it seems to nevertheless complete norma=
lly.  Here's an excerpt:
> =

> ########## Begin ##########
> CDPATH=3D"${ZSH_VERSION+.}:" && cd . && /bin/bash /home/daniel/git.lttng.=
org/lttng-ust-2.1.1+-ac6b4ac/config/missing --run aclocal-1.11 -I config
>  cd . && /bin/bash /home/daniel/git.lttng.org/lttng-ust-2.1.1+-ac6b4ac/co=
nfig/missing --run automake-1.11 --foreign
> CDPATH=3D"${ZSH_VERSION+.}:" && cd . && /bin/bash /home/daniel/git.lttng.=
org/lttng-ust-2.1.1+-ac6b4ac/config/missing --run autoconf
> /bin/bash ./config.status --recheck
> running CONFIG_SHELL=3D/bin/bash /bin/bash ./configure --with-java-jdk=3D=
/usr/lib/jvm/java-1.7.0-openjdk-amd64 --with-jni-interface LDFLAGS=3D-L/usr=
/local/lib --no-create --no-recursion
> checking build system type... x86_64-unknown-linux-gnu
> [...]
> checking for jni.h... yes
> configure: creating ./config.status
> =

> Version name: Basse Messe
> Light coloured German ale whose style was named after the city Cologne (K=
oln) where it was first brewed. It is a rather simple beer with lightly fru=
ity aromas and a delicate hoppy fragrance. The beer has a pronounced malty =
taste with a subtle bitter aftertaste
> =

> LTTng-UST will be built with the following options:
> =

> Java support (JNI): Enabled
> sdt.h integration:  Disabled
> =

> Type 'make' to compile.
>  /bin/bash ./config.status
> config.status: creating Makefile
> [...]
> config.status: executing libtool commands
> (CDPATH=3D"${ZSH_VERSION+.}:" && cd . && /bin/bash /home/daniel/git.lttng=
.org/lttng-ust-2.1.1+-ac6b4ac/config/missing --run autoheader)
> rm -f stamp-h1
> touch config.h.in
> cd . && /bin/bash ./config.status config.h
> config.status: creating config.h
> config.status: config.h is unchanged
> make  all-recursive
> make[1]: entrant dans le r=E9pertoire =AB /home/daniel/git.lttng.org/lttn=
g-ust-2.1.1+-ac6b4ac =BB
> Making all in .
> [...]
> Making all in libringbuffer
> make[2]: entrant dans le r=E9pertoire =AB /home/daniel/git.lttng.org/lttn=
g-ust-2.1.1+-ac6b4ac/libringbuffer =BB
>   CC     libringbuffer_la-smp.lo
>   CC     libringbuffer_la-shm.lo
> shm.c: In function '_shm_object_table_alloc_shm':
> shm.c:148:9: warning: ignoring return value of 'mktemp', declared with at=
tribute warn_unused_result [-Wunused-result]

Fixed by:

commit af21f7816739b0f9db8b4006ef4378ddc2de0157
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Date:   Tue May 7 09:16:39 2013 -0400

    Cleanup: ignore mktemp return value
    =

    Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

>   CC     libringbuffer_la-ring_buffer_backend.lo
>   CC     libringbuffer_la-ring_buffer_frontend.lo
>   CCLD   libringbuffer.la
> make[2]: quittant le r=E9pertoire =AB /home/daniel/git.lttng.org/lttng-us=
t-2.1.1+-ac6b4ac/libringbuffer =BB
> [...]
> Making all in hello
> make[3]: entrant dans le r=E9pertoire =AB /home/daniel/git.lttng.org/lttn=
g-ust-2.1.1+-ac6b4ac/tests/hello =BB
>   CC     hello-hello.o
> In file included from /usr/include/x86_64-linux-gnu/sys/socket.h:40:0,
>                  from /usr/include/netinet/in.h:25,
>                  from /usr/include/arpa/inet.h:23,
>                  from hello.c:29:
> /usr/include/x86_64-linux-gnu/bits/socket.h:433:23: attention : 'struct m=
msghdr' declared inside parameter list [enabled by default]
> /usr/include/x86_64-linux-gnu/bits/socket.h:433:23: attention : visible u=
niquement depuis cette d=E9finition ou d=E9claration, ce qui n'est probable=
ment pas ce que vous d=E9sirez [enabled by default]
> /usr/include/x86_64-linux-gnu/bits/socket.h:440:8: attention : 'struct mm=
sghdr' declared inside parameter list [enabled by default]

These are caused by missing "struct mmsghdr" declarations in system
headers. The reason why we see those is because we need to use
-Wsystem-headers when compiling tracepoint probe providers.

Thanks,

Mathieu

>   CC     hello-tp.o
>   CCLD   hello
> make[3]: quittant le r=E9pertoire =AB /home/daniel/git.lttng.org/lttng-us=
t-2.1.1+-ac6b4ac/tests/hello =BB
> Making all in hello-static-lib
> make[3]: entrant dans le r=E9pertoire =AB /home/daniel/git.lttng.org/lttn=
g-ust-2.1.1+-ac6b4ac/tests/hello-static-lib =BB
>   CC     tp.lo
>   CCLD   liblttng-ust-provider-ust-test-hello.la
>   CC     hello.o
> In file included from /usr/include/x86_64-linux-gnu/sys/socket.h:40:0,
>                  from /usr/include/netinet/in.h:25,
>                  from /usr/include/arpa/inet.h:23,
>                  from hello.c:29:
> /usr/include/x86_64-linux-gnu/bits/socket.h:433:23: attention : 'struct m=
msghdr' declared inside parameter list [enabled by default]
> /usr/include/x86_64-linux-gnu/bits/socket.h:433:23: attention : visible u=
niquement depuis cette d=E9finition ou d=E9claration, ce qui n'est probable=
ment pas ce que vous d=E9sirez [enabled by default]
> /usr/include/x86_64-linux-gnu/bits/socket.h:440:8: attention : 'struct mm=
sghdr' declared inside parameter list [enabled by default]
>   CCLD   hello
> make[3]: quittant le r=E9pertoire =AB /home/daniel/git.lttng.org/lttng-us=
t-2.1.1+-ac6b4ac/tests/hello-static-lib =BB
> [...]
> Making all in demo
> make[3]: entrant dans le r=E9pertoire =AB /home/daniel/git.lttng.org/lttn=
g-ust-2.1.1+-ac6b4ac/tests/demo =BB
>   CC     tp.lo
>   CC     tp2.lo
>   CCLD   liblttng-ust-provider-ust-tests-demo.la
>   CC     tp3.lo
>   CCLD   liblttng-ust-provider-ust-tests-demo3.la
>   CC     demo.o
> In file included from /usr/include/x86_64-linux-gnu/sys/socket.h:40:0,
>                  from /usr/include/netinet/in.h:25,
>                  from /usr/include/arpa/inet.h:23,
>                  from demo.c:29:
> /usr/include/x86_64-linux-gnu/bits/socket.h:433:23: attention : 'struct m=
msghdr' declared inside parameter list [enabled by default]
> /usr/include/x86_64-linux-gnu/bits/socket.h:433:23: attention : visible u=
niquement depuis cette d=E9finition ou d=E9claration, ce qui n'est probable=
ment pas ce que vous d=E9sirez [enabled by default]
> /usr/include/x86_64-linux-gnu/bits/socket.h:440:8: attention : 'struct mm=
sghdr' declared inside parameter list [enabled by default]
>   CCLD   demo
> make[3]: quittant le r=E9pertoire =AB /home/daniel/git.lttng.org/lttng-us=
t-2.1.1+-ac6b4ac/tests/demo =BB
> [...]
> make[1]: quittant le r=E9pertoire =AB /home/daniel/git.lttng.org/lttng-us=
t-2.1.1+-ac6b4ac =BB
> ########## End ##########
> =

>    Is all this normal?  I used the following script:
> =

> $ ./bootstrap &> bootstrap.log
> $ LDFLAGS=3D-L/usr/local/lib ./configure --with-java-jdk=3D/usr/lib/jvm/j=
ava-1.7.0-openjdk-amd64 --with-jni-interface &> configure.log
> $ make &> make.log
> =

> Daniel U. Thibault
> R & D pour la d=E9fense Canada - Valcartier (RDDC Valcartier) / Defence R=
&D Canada - Valcartier (DRDC Valcartier)
> Cyber s=E9curit=E9 pour les missions essentielles (CME) / Mission Critica=
l Cyber Security (MCCS)
> Protection des syst=E8mes et contremesures (PSC) / Systems Protection & C=
ountermeasures (SPC)
> 2459 route de la Bravoure
> Qu=E9bec, QC=A0 G3J 1X5
> CANADA
> Vox=A0: (418) 844-4000 x4245
> Fax=A0: (418) 844-4538
> NAC=A0: 918V QSDJ <http://www.travelgis.com/map.asp?addr=3D918V%20QSDJ>
> Gouvernement du Canada=A0/ Government of Canada
> <http://www.valcartier.drdc-rddc.gc.ca/>
> =

> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- =

Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
