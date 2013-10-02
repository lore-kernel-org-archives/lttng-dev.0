From: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Subject: Re: Making 32-bit user-space events on a 64-bit Linux
 system
Date: Wed, 2 Oct 2013 19:07:56 +0000
Message-ID: <48CF5AC71E61DB46B70D0F388054EFFD267956BE__11674.4180363186$1380740943$gmane$org@VAL-E-02.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from fw.drenet.dnd.ca ([131.136.242.1] helo=mx.drdc-rddc.gc.ca)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Daniel.Thibault@drdc-rddc.gc.ca>) id 1VRRmL-0003lN-Px
	for lttng-dev@lists.lttng.org; Wed, 02 Oct 2013 15:08:15 -0400
Content-Language: fr-FR
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
Cc: "jeremie.galarneau@gmail.com" <jeremie.galarneau@gmail.com>
List-Id: lttng-dev@lists.lttng.org

   Thanks for the help, I think I've cracked it now.  There are a few minor=
 nagging points, however.  I'll get to those at the end of this post.

   Recap: How does one generate and capture 32-bit user-space events on a 6=
4-bit system?

   The process consists essentially of making a 32-bit lttng-consumerd that=
 the 64-bit lttng-sessiond can use.

   First off, you will need 32-bit development libraries.  This is mostly a=
chieved by installing the gcc-multilib and g++-multilib packages.  The ia32=
-libs package could also be of use, as are a scattering of lib32* packages,=
 but I did not need them.  I did have a spot of difficulty getting the 32-b=
it versions of popt and uuid, however (they're not in ia32-libs as of Ubunt=
u 12.04 Precise).  Synaptic does not make that easy, although command-line =
'apt get' may be a better approach.  The important thing is to get /usr/loc=
al/lib32 populated with libpopt.so and libuuid.so (in the libuuid case, I i=
nstalled libuuid1:i386 and then linked from /usr/lib/i386-linux-gnu/libuuid=
.so to /lib/i386-linux-gnu/libuuid.so.1.3.0, which serves the same purpose).

   Next, deploy the sources for userspace-rcu, lttng-ust and lttng-tools to=
 a 32-bit working directory.  We will build a partial 32-bit LTTng toolchai=
n, being careful not to overwrite the installed 64-bit toolchain.

  The build procedure is as before, except that the ./configure line change=
s:

userspace-rcu-32:

$ ./bootstrap 2>&1 | tee bootstrap.log
$ ./configure --libdir=3D/usr/local/lib32 CFLAGS=3D"-m32 -O2" 2>&1 | tee co=
nfigure.log
$ make 2>&1 | tee make.log
$ sudo make install 2>&1 | tee install.log
$ sudo ldconfig

   Instead of CFLAGS=3D"-m32 -O2", you could use CC=3D"gcc -m32 -O2" and LD=
=3D"gcc -m32 -O2", which should yield the same results.

lttng-ust-32:

$ ./bootstrap 2>&1 | tee bootstrap.log
$ ./configure LDFLAGS=3D-L/usr/local/lib32 --libdir=3D/usr/local/lib32 CFLA=
GS=3D"-m32 -O2" 2>&1 | tee configure.log
$ make 2>&1 | tee make.log
$ sudo make install 2>&1 | tee install.log
$ sudo ldconfig

   If you have Java installed and/or SystemTap, you may want to add to the =
./configure line "--with-jni-interface --with-java-jdk=3D<path to JDK> --wi=
th-sdt", although I suspect this isn't really necessary (we only want a wor=
king 32-bit lttng-consumerd, after all).

lttng-tools-32:

$ ./bootstrap 2>&1 | tee bootstrap.log
$ ./configure LDFLAGS=3D-L/usr/local/lib32 --bindir=3D/usr/local/bin32 --li=
bdir=3D/usr/local/lib32 CFLAGS=3D"-m32 -O2" --with-consumerd-only --with-co=
nsumerd64-bin=3D/usr/local/lib/lttng/libexec/lttng-consumerd --with-consume=
rd64-libdir=3D/usr/local/lib 2>&1 | tee configure.log
$ make 2>&1 | tee make.log
$ sudo make install 2>&1 | tee install.log
$ sudo ldconfig

   After the configure step, you may need/want to edit the Makefile in orde=
r to remove 'tests' from the SUBDIRS (see below for the reason why).
   Note how we ask lttng-tools to make just lttng-consumerd (--with-consume=
rd-only) and how we hooked the 64-bit consumer in (--with-consumerd64-bin a=
nd --with-consumerd64-libdir).

   Finally, we redo the 64-bit lttng-tools to hook in our 32-bit lttng-cons=
umerd:

lttng-tools-64:

$ ./bootstrap 2>&1 | tee bootstrap.log
$ ./configure LDFLAGS=3D-L/usr/local/lib --with-consumerd32-bin=3D/usr/loca=
l/lib32/lttng/libexec/lttng-consumerd --with-consumerd32-libdir=3D/usr/loca=
l/lib32 2>&1 | tee configure.log
$ make 2>&1 | tee make.log
$ sudo make install 2>&1 | tee install.log
$ sudo ldconfig

   Henceforth, the lttng-sessiond daemon will run with the correct 32-bit l=
ttng-consumerd.

   Meanwhile, we need a simple source of 32-bit user-space events.  The sim=
plest can be made from the lttng-ust/doc/examples/easy-ust.  Edit the Makef=
ile to add a static32 target:

static32: static32.o tp32.o
        @echo "~~~~~~Linking sample_$@:"
        $(CC) -m32 -o sample_$@ $^ $(LDFLAGS) $(LIBDL) $(LIBUST)
        @echo "   Use 'LD_PRELOAD=3D/usr/local/lib32/liblttng-ust.so ./samp=
le_$@' to run sample_$@"

static32.o: sample.c tp.h
        @echo "~~~~~~Compiling $@:"
        $(CC) -m32 $(CPPFLAGS) $(LOCAL_CPPFLAGS) $(TP_DEFINE) -c -o $@ $<

tp32.o: tp.c tp.h
        @echo "~~~~~~Compiling $@:"
        $(CC) -m32 $(CPPFLAGS) $(LOCAL_CPPFLAGS) -c -o $@ $<

   From lttng-ust/doc/examples/easy-ust , call:

$ LDFLAGS=3D-L/usr/local/lib32 make static32

   You can then invoke sample_static32 with:
$ LD_PRELOAD=3D/usr/local/lib32/liblttng-ust.so ./sample_static32

   Running an lttng session with all user-space events enabled, I did indee=
d capture ust/uid/1000/32-bit/channel0_0 and ust/uid/1000/64-bit/channel0_0.

   Closing observations:

   What's the best, easiest way to get the 32-bit versions of popt and uuid?

   My lttng-tools-32 make ran into trouble with the 'tests/unit' subdirecto=
ry (error below).  Is this an actual bug?

  CC     ../../src/bin/lttng-sessiond/session.o
../../src/bin/lttng-sessiond/session.c:249:1: erreur fatale: ouverture du f=
ichier de d=E9pendances .deps/../../src/bin/lttng-sessiond/session.Tpo: Auc=
un fichier ou dossier de ce type

   Why did the lttng-tools make not restrict itself to the lttng-consumerd =
daemon as requested?

   Couldn't the lttng-tools build detect it's running in a 64-bit system an=
d at least try to make a proper 32-bit consumer daemon (and supporting libr=
aries)?  Maybe this could be a configure switch, off by default.

   In building the 32-bit consumer daemon, could we skip the with-consumerd=
64-* options?
   How many of the lib32 lttng libraries (apart from liblttng-ust, of cours=
e) are deletable?  sample_static32 needs liburcu-bp, liburcu-cds, liblttng-=
ust-tracepoint in order to run; lttng-consumerd needs liburcu and liblttng-=
ust-ctl.  That's as far as ldd can detect: there could be dlopen calls lurk=
ing in there.  Are liblttng-ctl, liblttng-ust-cyg-profile, liblttng-ust-cyg=
-profile-fast, liblttng-ust-fork, liblttng-ust-java, liblttng-ust-libc-wrap=
per, liburcu-common, liburcu-mb, liburcu-qsbr, and liburcu-signal superfluo=
us?

Daniel U. Thibault
Protection des syst=E8mes et contremesures (PSC) | Systems Protection & Cou=
ntermeasures (SPC)
Cyber s=E9curit=E9 pour les missions essentielles (CME) | Mission Critical =
Cyber Security (MCCS)
R & D pour la d=E9fense Canada - Valcartier (RDDC Valcartier) | Defence R&D=
 Canada - Valcartier (DRDC Valcartier)
2459 route de la Bravoure
Qu=E9bec QC  G3J 1X5
CANADA
Vox : (418) 844-4000 x4245
Fax : (418) 844-4538
NAC : 918V QSDJ <http://www.travelgis.com/map.asp?addr=3D918V%20QSDJ>
Gouvernement du Canada | Government of Canada
<http://www.valcartier.drdc-rddc.gc.ca/>
