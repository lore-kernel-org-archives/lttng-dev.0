From: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Subject: Re: Making 32-bit user-space events on a 64-bit Linux
 system
Date: Wed, 2 Oct 2013 14:35:04 +0000
Message-ID: <48CF5AC71E61DB46B70D0F388054EFFD267955A8__41970.554754562$1380724570$gmane$org@VAL-E-02.valcartier.drdc-rddc.gc.ca>
References: <48CF5AC71E61DB46B70D0F388054EFFD2679540E@VAL-E-02.valcartier.drdc-rddc.gc.ca>
	<524BCD4B.2020501@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from fw.drenet.dnd.ca ([131.136.242.1] helo=mx.drdc-rddc.gc.ca)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Daniel.Thibault@drdc-rddc.gc.ca>) id 1VRNW6-00025j-0n
	for lttng-dev@lists.lttng.org; Wed, 02 Oct 2013 10:35:11 -0400
In-Reply-To: <524BCD4B.2020501@mentor.com>
Content-Language: fr-FR
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "Woegerer, Paul" <Paul_Woegerer@mentor.com>, "jeremie.galarneau@gmail.com" <jeremie.galarneau@gmail.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

-----Message d'origine-----
De=A0: Woegerer, Paul [mailto:Paul_Woegerer@mentor.com] =

Envoy=E9=A0: 2 octobre 2013 03:38

> The 64-bit version of lttng-tools works just fine with both, 32-bit and 6=
4-bit userspace applications. No need to compile it as 32-bit variant.
> Instrumented 32-bit applications automatically use the 32-bit lttng-consu=
merd (from the lttng-ust 32-bit build), instrumented 64-bit =

> applications automatically use the 64-bit lttng-consumerd (from the lttng=
-ust 64-bit build).

   But lttng-consumerd is in the lttng-tools package, not lttng-ust ?!  Thi=
s prevents my lttng-sessiond from using a 32-bit lttng-consumerd, as you'll=
 see below.

> BTW, when you compile for the "-m32" multilib, it's better to use the fol=
lowing:
> $ ./configure CC=3D"gcc -m32"
> This way also the linking steps (performed by libtool) of your build will=
 know that you are building for m32 (on your x86_64 system) and you don't n=
eed e.g. "--libdir ....".

   That's what I did, but I still felt I needed to specify libdir so the in=
stall did not overwrite the 64-bit libraries (liblttng-ctl.so, liblttng-ust=
.so, etc.).

> For more information see:
> http://doc.opensuse.org/documentation/html/openSUSE/opensuse-reference/ch=
a.64bit.html#sec.64bit.biarch
> or
> https://developer.mozilla.org/en/docs/Compiling_32-bit_Firefox_on_a_Linux=
_64-bit_OS

   I have seen the second one, which was moderately useul.  I'll look into =
the first one, thanks.

> > More generally, how does one add tracepoints to a 32-bit application ru=
nning on a 64-bit system?
>
> You simply compile your instrumented application to 32-bit the same way y=
ou did it for the lttng-ust package (CC=3D"gcc -m32").
>
> Paul Woegerer, SW Development Engineer

   Indeed, once lttng-ust has been done in 32-bits, I can use the 'make sta=
tic32' I quoted at the beginning of the thread like this:

$ LDFLAGS=3D-L/usr/local/lib32 make static 32

   And then run the sample app like this:

$ LD_PRELOAD=3D/usr/local/lib32/liblttng-ust.so ./sample_static32

   (I could dump the LD_PRELOAD by adding /usr/local/lib32 to my PATH)

   But my running lttng-sessiond (enable-event -u -a) complains:

Error: Consumer socket fd -1 not found in consumer obj 0x7ffd4000b650

   My guess is I'll need to launch lttng-sessiond with the -u and -U option=
s to point it to the 32-bit lttng-consumerd...Once I can get the 32-bit ltt=
ng-tools to compile and install it.

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
