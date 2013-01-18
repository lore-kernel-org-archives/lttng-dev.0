From: David Goulet <dgoulet@efficios.com>
Subject: Re: yacc lttng-tools problem
Date: Fri, 18 Jan 2013 13:30:20 -0500
Message-ID: <50F994BC.9090503__5119.58226929909$1358533877$gmane$org@efficios.com>
References: <3CA1A65C03C1A34C81BBC6272782E696987823@valcartierex01.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([213.239.202.151])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <dgoulet@efficios.com>) id 1TwGhs-0004iJ-EC
	for lttng-dev@lists.lttng.org; Fri, 18 Jan 2013 13:30:24 -0500
In-Reply-To: <3CA1A65C03C1A34C81BBC6272782E696987823@valcartierex01.valcartier.drdc-rddc.gc.ca>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Cc: lttng-dev@lists.lttng.org, "Couture, Mario" <Mario.Couture@drdc-rddc.gc.ca>, =?ISO-8859-1?Q?=22Painchaud=2C_Fr=E9d=E9?= =?ISO-8859-1?Q?ric=22?= <Frederic.Painchaud@drdc-rddc.gc.ca>
List-Id: lttng-dev@lists.lttng.org

Do a ./bootstrap to update or generate again ylwrap.

Make sure also you have these packages:

- flex >=3D 2.5.35
- bison >=3D 2.4

Thanks!
David

Thibault, Daniel:
>    I need help to get lttng-tools to compile.
> =

>    I have grabbed the (nearly) latest git.lttng.org packages:
> =

> lttng-modules (2.1.0+-c6403de)
> userspace-rcu (0.7.6-da9bed2)
> lttng-ust (2.1.0+-340f776) (one new commit since)
> lttng-tools (2.1.1+-281047b) (six new commits since)
> =

>    The userspace-rcu repository is weird: the 0.7.6 commit which I fetche=
d is marked as "8 days ago" but the master stops at "11 days ago".
> =

>    I've installed (on my Ubuntu 12.04 system) libtool, texinfo, g++, libp=
opt-dev, and bison.  I'm not completely sure about bison: this was prompted=
 by an earlier failed make that choked on a yacc invocation.  Maybe the bya=
cc package is better indicated?
> =

>    Anyway, so far lttng-modules, userspace-rcu and lttng-ust have all com=
piled and installed correctly.  But when lttng-tools's turn comes, the make=
 fails with:
> =

> make[4]: entrant dans le r=E9pertoire =AB /home/daniel/Documents/lttng-to=
ols-2.1.1+-281047b/src/lib/lttng-ctl/filter =BB
> /bin/bash ../../../../config/ylwrap filter-parser.y y.tab.c filter-parser=
.c y.tab.h filter-parser.h y.output filter-parser.output -- bison -y  -t -d=
 -v
> updating filter-parser.h
> updating filter-parser.output
> make  all-am
> make[5]: entrant dans le r=E9pertoire =AB /home/daniel/Documents/lttng-to=
ols-2.1.1+-281047b/src/lib/lttng-ctl/filter =BB
> /bin/bash ../../../../config/ylwrap filter-lexer.l .c filter-lexer.c -- :=
  =

> make[5]: *** [filter-lexer.c] Erreur 1
> make[5]: quittant le r=E9pertoire =AB /home/daniel/Documents/lttng-tools-=
2.1.1+-281047b/src/lib/lttng-ctl/filter =BB
> make[4]: *** [all] Erreur 2
> make[4]: quittant le r=E9pertoire =AB /home/daniel/Documents/lttng-tools-=
2.1.1+-281047b/src/lib/lttng-ctl/filter =BB
> make[3]: *** [all-recursive] Erreur 1
> make[3]: quittant le r=E9pertoire =AB /home/daniel/Documents/lttng-tools-=
2.1.1+-281047b/src/lib/lttng-ctl =BB
> make[2]: *** [all-recursive] Erreur 1
> make[2]: quittant le r=E9pertoire =AB /home/daniel/Documents/lttng-tools-=
2.1.1+-281047b/src/lib =BB
> make[1]: *** [all-recursive] Erreur 1
> make[1]: quittant le r=E9pertoire =AB /home/daniel/Documents/lttng-tools-=
2.1.1+-281047b/src =BB
> make: *** [all-recursive] Erreur 1
> =

> Daniel U. Thibault
> R & D pour la d=E9fense Canada - Valcartier (RDDC Valcartier) / Defence R=
&D Canada - Valcartier (DRDC Valcartier)
> Cyber s=E9curit=E9 pour les missions essentielles (CME) / Mission Critica=
l Cyber Security (MCCS)
> Protection des syst=E8mes et contremesures (PSC) / Systems Protection & C=
ountermeasures (SPC)
> 2459 route de la Bravoure
> Qu=E9bec, QC  G3J 1X5
> CANADA
> Vox : (418) 844-4000 x4245
> Fax : (418) 844-4538
> NAC : 918V QSDJ <http://www.travelgis.com/map.asp?addr=3D918V%20QSDJ>
> Gouvernement du Canada / Government of Canada
> <http://www.valcartier.drdc-rddc.gc.ca/>
> =

> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
