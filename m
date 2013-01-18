From: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Subject: yacc lttng-tools problem
Date: Fri, 18 Jan 2013 12:37:07 -0500
Message-ID: <3CA1A65C03C1A34C81BBC6272782E696987823__30582.347411155$1358530696$gmane$org@valcartierex01.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from fw.drenet.dnd.ca ([131.136.242.1] helo=mx.drdc-rddc.gc.ca)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Daniel.Thibault@drdc-rddc.gc.ca>) id 1TwFsc-0004HB-No
	for lttng-dev@lists.lttng.org; Fri, 18 Jan 2013 12:37:26 -0500
Content-class: urn:content-classes:message
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
Cc: =?iso-8859-1?Q?Painchaud=2C_Fr=E9d=E9ric?= <Frederic.Painchaud@drdc-rddc.gc.ca>, "Couture,
	Mario" <Mario.Couture@drdc-rddc.gc.ca>
List-Id: lttng-dev@lists.lttng.org

   I need help to get lttng-tools to compile.

   I have grabbed the (nearly) latest git.lttng.org packages:

lttng-modules (2.1.0+-c6403de)
userspace-rcu (0.7.6-da9bed2)
lttng-ust (2.1.0+-340f776) (one new commit since)
lttng-tools (2.1.1+-281047b) (six new commits since)

   The userspace-rcu repository is weird: the 0.7.6 commit which I fetched =
is marked as "8 days ago" but the master stops at "11 days ago".

   I've installed (on my Ubuntu 12.04 system) libtool, texinfo, g++, libpop=
t-dev, and bison.  I'm not completely sure about bison: this was prompted b=
y an earlier failed make that choked on a yacc invocation.  Maybe the byacc=
 package is better indicated?

   Anyway, so far lttng-modules, userspace-rcu and lttng-ust have all compi=
led and installed correctly.  But when lttng-tools's turn comes, the make f=
ails with:

make[4]: entrant dans le r=E9pertoire =AB /home/daniel/Documents/lttng-tool=
s-2.1.1+-281047b/src/lib/lttng-ctl/filter =BB
/bin/bash ../../../../config/ylwrap filter-parser.y y.tab.c filter-parser.c=
 y.tab.h filter-parser.h y.output filter-parser.output -- bison -y  -t -d -v
updating filter-parser.h
updating filter-parser.output
make  all-am
make[5]: entrant dans le r=E9pertoire =AB /home/daniel/Documents/lttng-tool=
s-2.1.1+-281047b/src/lib/lttng-ctl/filter =BB
/bin/bash ../../../../config/ylwrap filter-lexer.l .c filter-lexer.c -- :  =

make[5]: *** [filter-lexer.c] Erreur 1
make[5]: quittant le r=E9pertoire =AB /home/daniel/Documents/lttng-tools-2.=
1.1+-281047b/src/lib/lttng-ctl/filter =BB
make[4]: *** [all] Erreur 2
make[4]: quittant le r=E9pertoire =AB /home/daniel/Documents/lttng-tools-2.=
1.1+-281047b/src/lib/lttng-ctl/filter =BB
make[3]: *** [all-recursive] Erreur 1
make[3]: quittant le r=E9pertoire =AB /home/daniel/Documents/lttng-tools-2.=
1.1+-281047b/src/lib/lttng-ctl =BB
make[2]: *** [all-recursive] Erreur 1
make[2]: quittant le r=E9pertoire =AB /home/daniel/Documents/lttng-tools-2.=
1.1+-281047b/src/lib =BB
make[1]: *** [all-recursive] Erreur 1
make[1]: quittant le r=E9pertoire =AB /home/daniel/Documents/lttng-tools-2.=
1.1+-281047b/src =BB
make: *** [all-recursive] Erreur 1

Daniel U. Thibault
R & D pour la d=E9fense Canada - Valcartier (RDDC Valcartier) / Defence R&D=
 Canada - Valcartier (DRDC Valcartier)
Cyber s=E9curit=E9 pour les missions essentielles (CME) / Mission Critical =
Cyber Security (MCCS)
Protection des syst=E8mes et contremesures (PSC) / Systems Protection & Cou=
ntermeasures (SPC)
2459 route de la Bravoure
Qu=E9bec, QC=A0 G3J 1X5
CANADA
Vox=A0: (418) 844-4000 x4245
Fax=A0: (418) 844-4538
NAC=A0: 918V QSDJ <http://www.travelgis.com/map.asp?addr=3D918V%20QSDJ>
Gouvernement du Canada=A0/ Government of Canada
<http://www.valcartier.drdc-rddc.gc.ca/>
