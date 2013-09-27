From: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Subject: Making 32-bit user-space events on a 64-bit Linux system
Date: Fri, 27 Sep 2013 19:48:39 +0000
Message-ID: <48CF5AC71E61DB46B70D0F388054EFFD26793CA3__5778.4121636816$1380311362$gmane$org@VAL-E-02.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from fw.drenet.dnd.ca ([131.136.242.1] helo=mx.drdc-rddc.gc.ca)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Daniel.Thibault@drdc-rddc.gc.ca>) id 1VPe1o-0001m0-W3
	for lttng-dev@lists.lttng.org; Fri, 27 Sep 2013 15:48:43 -0400
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
List-Id: lttng-dev@lists.lttng.org

   I wanted to test the 32-bit UST event stream (to see if one can indeed h=
ave two consumer daemons serving the session, one for 64-bit user-space eve=
nts, another for 32-bit user-space events), so I adapted the lttng-ust/doc/=
examples/easy-ust Makefile by making a new target:

static32: static32.o tp32.o
	@echo "~~~~~~Linking sample_$@:"
	$(CC) -m32 -o sample_$@ $^ $(LDFLAGS) $(LIBDL) $(LIBUST)
	@echo "   Use './sample_$@' to run sample_$@"

static32.o: sample.c tp.h
	@echo "~~~~~~Compiling $@:"
	$(CC) -m32 $(CPPFLAGS) $(LOCAL_CPPFLAGS) $(TP_DEFINE) -c -o $@ $<

tp32.o: tp.c tp.h
	@echo "~~~~~~Compiling $@:"
	$(CC) -m32 $(CPPFLAGS) $(LOCAL_CPPFLAGS) -c -o $@ $<

   Simply put, the .c files are compiled and linked with an additional -m32=
 gcc option.  The gcc-multilib package is installed.

   However, I get:

$ make static32
~~~~~~Compiling static32.o:
gcc -m32  -I. -D TRACEPOINT_DEFINE -c -o static32.o sample.c
~~~~~~Compiling tp32.o:
gcc -m32  -I. -c -o tp32.o tp.c
~~~~~~Linking sample_static32:
gcc -m32 -o sample_static32 static32.o tp32.o -L/usr/local/lib -ldl  -llttn=
g-ust
/usr/bin/ld: warning: skipping incompatible /usr/local/lib/liblttng-ust.so =
while searching for lttng-ust
/usr/bin/ld: error: cannot find -llttng-ust
tp32.o:tp.c:function __lttng_events_init__sample_component: error: undefine=
d reference to 'lttng_probe_register'
tp32.o:tp.c:function __lttng_events_exit__sample_component: error: undefine=
d reference to 'lttng_probe_unregister'
collect2: ld a retourn=E9 1 code d'=E9tat d'ex=E9cution
make: *** [static32] Erreur 1

   The problem is the "incompatible /usr/local/lib/liblttng-ust.so".  I eve=
n tried rebuilding the entire lttng suite (originally built *before* gcc-mu=
ltilib was added), but that changed nothing.  How do I do this?  More gener=
ally, how does one add tracepoints to a 32-bit application running on a 64-=
bit system?

Daniel U. Thibault
Protection des syst=E8mes et contremesures (PSC) | Systems Protection & Cou=
ntermeasures (SPC)
Cyber s=E9curit=E9 pour les missions essentielles (CME) | Mission Critical =
Cyber Security (MCCS)
R & D pour la d=E9fense Canada - Valcartier (RDDC Valcartier) | Defence R&D=
 Canada - Valcartier (DRDC Valcartier)
2459 route de la Bravoure
Qu=E9bec QC=A0 G3J 1X5
CANADA
Vox=A0: (418) 844-4000 x4245
Fax=A0: (418) 844-4538
NAC=A0: 918V QSDJ <http://www.travelgis.com/map.asp?addr=3D918V%20QSDJ>
Gouvernement du Canada=A0| Government of Canada
<http://www.valcartier.drdc-rddc.gc.ca/>
