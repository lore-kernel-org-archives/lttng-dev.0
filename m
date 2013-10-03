From: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Subject: Re: Making 32-bit user-space events on a 64-bit Linux
 system
Date: Thu, 3 Oct 2013 13:53:27 +0000
Message-ID: <48CF5AC71E61DB46B70D0F388054EFFD2679582B__1003.14952801472$1380808478$gmane$org@VAL-E-02.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from fw.drenet.dnd.ca ([131.136.242.1] helo=mx.drdc-rddc.gc.ca)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Daniel.Thibault@drdc-rddc.gc.ca>) id 1VRjLZ-00034V-9S
	for lttng-dev@lists.lttng.org; Thu, 03 Oct 2013 09:53:47 -0400
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

-----Message d'origine-----
Date: Wed, 2 Oct 2013 19:07:56 +0000
>>    Closing observations:
>>
>>    What's the best, easiest way to get the 32-bit versions of popt and u=
uid?
>
> Some -dev packages are also multiarch, for example I can install libpopt-=
dev:amd64 and libpopt-dev:i386 at the same time (on Ubuntu
> 13.10) and get the "real" .so symlink from the package.
>
> It doesn't seem to be the case with uuid-dev though, I can only have one =
version installed at a time. But you can install one, compile what you
> need, then switch to the other one.
>
> ia32-libs has long been deprecated, it now simply depends on a bunch of :=
i386 libraries. What's sad is that it used to contain both the =

> libraries and the headers (so the equivalent of the -dev packages) it shi=
pped, whereas now the cross-arch dev files are a bit harder to get.

   Yeah, that situation is an absolute mess right now.  There apparently wa=
s a ppa with a 'getlibs' package that did precisely what is needed here: =

bolting 32-bit libraries onto a x86-64 system.  Sadly, the original ppa is =
gone, and I can only find scattered updates that go no further than Ubuntu =

Natty, apparently.

>>    My lttng-tools-32 make ran into trouble with the 'tests/unit' subdire=
ctory (error below).  Is this an actual bug?
>>
>>    Why did the lttng-tools make not restrict itself to the lttng-consume=
rd daemon as requested?
>
> These could be bugs in the build system. It's quite an obscure feature, s=
o it's not as well-tested...

   I tried this in a pure 64-bit context and the same error occurred.  I'm =
filing a bug.

>>    Couldn't the lttng-tools build detect it's running in a 64-bit system=
 and at least try to make a proper 32-bit consumer daemon (and supporting =

>> libraries)?  Maybe this could be a configure switch, off by default.
>
> This is hard to do with the current build system. Autotools basically let=
s you "build this one thing". If you want to build something 64 bits,
> and then something 32 bits, you have to run 'make' twice. And packaging t=
he result is a nightmare.

   Agreed, not worth the trouble.

>>    In building the 32-bit consumer daemon, could we skip the with-consum=
erd64-* options?
>
> You can probably skip those. They are used for the opposite case, where y=
ou want to compile a 32-bit daemon that will use a 64-bit consumer.

> The Debian/Ubuntu packages for liblttng-ust and liburcu are multiarch-ena=
bled, so you can install the :i386 and :amd64 versions in
> parallel. That way they will be tracked by the package manager, and won't=
 "linger around".

   Except that the Ubuntu LTTng packages are hopelessly behind right now.  =
I wanted to do everything with the 2.3.0 release.

#################################################

   On a different note, why does LTTng have 32- and 64-bit consumers anyway=
?  The only possible difference between a 32-bit tracer and a =

64-bit tracer is that the latter could generate event record fields that ar=
e 64-bit longs and floats, while the former cannot (but will never =

have to, since the application it is tracing won't have such beasts anyway)=
.  So the 64-bit consumer should be backward compatible with the
32-bit consumer, because it deals with a super-set of the 32-bit consumer r=
equirements.  If this were the only difference, LTTng would not
need a separate 32-bit consumer daemon.  Is there some sort of context-swit=
ching overhead associated with a 64-bit daemon accessing a
buffer that exists in a 32-bit process context?  The performance gain would=
 justify the existence of a 32-bit consumer, I suppose.

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
