From: Alexandre Montplaisir <alexmonthy@voxpopuli.im>
Subject: Re: Making 32-bit user-space events on a 64-bit Linux
 system
Date: Wed, 02 Oct 2013 17:14:26 -0400
Message-ID: <524C8CB2.1050902__28715.649029664$1380748616$gmane$org@voxpopuli.im>
References: <48CF5AC71E61DB46B70D0F388054EFFD267956BE@VAL-E-02.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from ironport2-out.teksavvy.com ([206.248.154.182])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <alexmonthy@voxpopuli.im>) id 1VRTlo-0000Px-5z
	for lttng-dev@lists.lttng.org; Wed, 02 Oct 2013 17:15:49 -0400
In-Reply-To: <48CF5AC71E61DB46B70D0F388054EFFD267956BE@VAL-E-02.valcartier.drdc-rddc.gc.ca>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Cc: lttng-dev@lists.lttng.org, jeremie.galarneau@gmail.com
List-Id: lttng-dev@lists.lttng.org

Hi Daniel,

Interesting, thanks for documenting your adventure! Some little notes:

On 13-10-02 03:07 PM, Thibault, Daniel wrote:
>    [...]
>
>    Closing observations:
>
>    What's the best, easiest way to get the 32-bit versions of popt and uu=
id?


Some -dev packages are also multiarch, for example I can install
libpopt-dev:amd64 and libpopt-dev:i386 at the same time (on Ubuntu
13.10) and get the "real" .so symlink from the package.

It doesn't seem to be the case with uuid-dev though, I can only have one
version installed at a time. But you can install one, compile what you
need, then switch to the other one.

ia32-libs has long been deprecated, it now simply depends on a bunch of
:i386 libraries. What's sad is that it used to contain both the
libraries and the headers (so the equivalent of the -dev packages) it
shipped, whereas now the cross-arch dev files are a bit harder to get.

>
>    My lttng-tools-32 make ran into trouble with the 'tests/unit' subdirec=
tory (error below).  Is this an actual bug?
>
>   CC     ../../src/bin/lttng-sessiond/session.o
> ../../src/bin/lttng-sessiond/session.c:249:1: erreur fatale: ouverture du=
 fichier de d=E9pendances .deps/../../src/bin/lttng-sessiond/session.Tpo: A=
ucun fichier ou dossier de ce type
>
>    Why did the lttng-tools make not restrict itself to the lttng-consumer=
d daemon as requested?

These could be bugs in the build system. It's quite an obscure feature,
so it's not as well-tested...

>    Couldn't the lttng-tools build detect it's running in a 64-bit system =
and at least try to make a proper 32-bit consumer daemon (and supporting li=
braries)?  Maybe this could be a configure switch, off by default.

This is hard to do with the current build system. Autotools basically
lets you "build this one thing". If you want to build something 64 bits,
and then something 32 bits, you have to run 'make' twice. And packaging
the result is a nightmare.

>
>    In building the 32-bit consumer daemon, could we skip the with-consume=
rd64-* options?

You can probably skip those. They are used for the opposite case, where
you want to compile a 32-bit daemon that will use a 64-bit consumer.

>    How many of the lib32 lttng libraries (apart from liblttng-ust, of cou=
rse) are deletable?  sample_static32 needs liburcu-bp, liburcu-cds, liblttn=
g-ust-tracepoint in order to run; lttng-consumerd needs liburcu and liblttn=
g-ust-ctl.  That's as far as ldd can detect: there could be dlopen calls lu=
rking in there.  Are liblttng-ctl, liblttng-ust-cyg-profile, liblttng-ust-c=
yg-profile-fast, liblttng-ust-fork, liblttng-ust-java, liblttng-ust-libc-wr=
apper, liburcu-common, liburcu-mb, liburcu-qsbr, and liburcu-signal superfl=
uous?

The different liblttng-ust-* libraries are used for different features
(cyg-profile, java JNI interface, fork() tracing). If you want the
feature to be available for 32-bit applications, you need the library.
The liburcu ones that are really unused could be deleted, if you want to
take the risk. They are quite small though, is disk space that much of a
problem?

The Debian/Ubuntu packages for liblttng-ust and liburcu are
multiarch-enabled, so you can install the :i386 and :amd64 versions in
parallel. That way they will be tracked by the package manager, and
won't "linger around".


Hope this helps,
Alexandre
