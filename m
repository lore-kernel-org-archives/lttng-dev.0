From: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Subject: Re: Odd dependency for lttng-ust - resolved
Date: Fri, 25 Jan 2013 13:26:47 -0500
Message-ID: <3CA1A65C03C1A34C81BBC6272782E696987A7F__28467.2720278197$1359138480$gmane$org@valcartierex01.valcartier.drdc-rddc.gc.ca>
References: <3CA1A65C03C1A34C81BBC6272782E696987A76@valcartierex01.valcartier.drdc-rddc.gc.ca>
	<5102C77A.5040409@voxpopuli.im>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from fw.drenet.dnd.ca ([131.136.242.1] helo=mx.drdc-rddc.gc.ca)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Daniel.Thibault@drdc-rddc.gc.ca>) id 1Tynze-000264-Gy
	for lttng-dev@lists.lttng.org; Fri, 25 Jan 2013 13:27:14 -0500
Content-class: urn:content-classes:message
In-Reply-To: <5102C77A.5040409@voxpopuli.im>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Alexandre Montplaisir <alexmonthy@voxpopuli.im>
Cc: lttng-dev@lists.lttng.org, "Couture, Mario" <Mario.Couture@drdc-rddc.gc.ca>, "Painchaud, Frederic" <Frederic.Painchaud@drdc-rddc.gc.ca>
List-Id: lttng-dev@lists.lttng.org

-----Message d'origine-----
De=A0: Alexandre Montplaisir [mailto:alexmonthy@voxpopuli.im] =

Envoy=E9=A0: 25 janvier 2013 12:57

On 13-01-25 12:32 PM, Thibault, Daniel wrote:
> [...]
>    Until this old gold bug is fixed (which looks unlikely considering its=
 age), maybe each package's configure.ac could be made to explicitly look i=
nto /usr/local/lib when /lib and /usr/lib fail?  Or the ReadMe files of ltt=
ng-ust and lttng-tools could be modified to mention the workaround?

I'm not sure if they are any distro that uses gold by default, instead of t=
he more venerable/tested "ld". I know Ubuntu doesn't.

I think in your case the problem was because you still had the libraries fr=
om Ubuntu's older package installed in /usr/lib, and as you mentioned, the =
linker looks in that location before trying /usr/local/lib. In such a "cust=
om" setup, you would need to override LDFLAGS. But someone that has nothing=
 installed in /usr/lib should get the libraries in /usr/local/lib selected =
by the linker automatically.

Cheers,
Alexandre
-----Fin du message d'origine-----

   Nope, my /usr/lib is clean.  The problem is unavoidable on a clean syste=
m because lttng-tools's README lists GNU Gold (2.22 or better) in its requi=
rements when building from git.  On the other hand, if you had a liburcu pa=
ckage installed and it were not too old, configure's checks would be passed=
.  You could run into trouble during the make though, depending on which li=
burcu (/usr/lib vs. /usr/local/lib) it linked against.  But that scenario i=
s moot as Mathieu rightly warned against mixing old and new stuff together.

   "But someone that has nothing installed in /usr/lib should get the libra=
ries in /usr/local/lib selected by the linker automatically."  Only if usin=
g ld.bfd or if binutils-gold were not installed -in which latter case one w=
ould not be following the instructions.  (See http://stackoverflow.com/ques=
tions/5873516/shared-library-in-usr-local-lib-not-found for a very similar =
problem and its diagnostic; this is the page that clinched it for me)

Daniel U. Thibault
R & D pour la d=E9fense Canada - Valcartier (RDDC Valcartier) / Defence R&D=
 Canada - Valcartier (DRDC Valcartier)
Cyber s=E9curit=E9 pour les missions essentielles (CME) / Mission Critical =
Cyber Security (MCCS)
Protection des syst=E8mes et contremesures (PSC) / Systems Protection & Cou=
ntermeasures (SPC)
2459 route de la Bravoure
Qu=E9bec, QC  G3J 1X5
CANADA
Vox : (418) 844-4000 x4245
Fax : (418) 844-4538
[Valcartier]\\vsi-wdut-o980, [Secteur-SI]\\edge
NAC : 918V QSDJ <http://www.travelgis.com/map.asp?addr=3D918V%20QSDJ>
Gouvernement du Canada / Government of Canada
<http://www.valcartier.drdc-rddc.gc.ca/>
 LinkedIn: <http://ca.linkedin.com/in/daniel-u-thibault/>
 Research Gate: <https://www.researchgate.net/profile/Daniel_Thibault/>
