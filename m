From: "Woegerer, Paul" <Paul_Woegerer@mentor.com>
Subject: Re: Making 32-bit user-space events on a 64-bit Linux
 system
Date: Wed, 2 Oct 2013 17:46:13 +0200
Message-ID: <524C3FC5.6090600__41884.9064190455$1380728844$gmane$org@mentor.com>
References: <48CF5AC71E61DB46B70D0F388054EFFD2679540E@VAL-E-02.valcartier.drdc-rddc.gc.ca>
	<524BCD4B.2020501@mentor.com>
	<48CF5AC71E61DB46B70D0F388054EFFD267955A8@VAL-E-02.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from relay1.mentorg.com ([192.94.38.131])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Paul_Woegerer@mentor.com>) id 1VROd7-0004la-2B
	for lttng-dev@lists.lttng.org; Wed, 02 Oct 2013 11:46:30 -0400
In-Reply-To: <48CF5AC71E61DB46B70D0F388054EFFD267955A8@VAL-E-02.valcartier.drdc-rddc.gc.ca>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>, "jeremie.galarneau@gmail.com" <jeremie.galarneau@gmail.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

ling On 10/02/2013 04:35 PM, Thibault, Daniel wrote:
> -----Message d'origine-----
> De : Woegerer, Paul [mailto:Paul_Woegerer@mentor.com] =

> Envoy=E9 : 2 octobre 2013 03:38
>
>> The 64-bit version of lttng-tools works just fine with both, 32-bit and =
64-bit userspace applications. No need to compile it as 32-bit variant.
>> Instrumented 32-bit applications automatically use the 32-bit lttng-cons=
umerd (from the lttng-ust 32-bit build), instrumented 64-bit =

>> applications automatically use the 64-bit lttng-consumerd (from the lttn=
g-ust 64-bit build).
>    But lttng-consumerd is in the lttng-tools package, not lttng-ust ?!  T=
his prevents my lttng-sessiond from using a 32-bit lttng-consumerd, as you'=
ll see below.

Right. Now that you say it, I DO remember compiling lttng-tools twice. I
took only the lttng-consumerd from the 32-bit variant and copied it over
into the 64-bit install tree and recompiled for 64-bit with
--with-consumerd32-bin=3D<lttng_install_root>/lib/lttng/libexec/lttng-consu=
merd
--with-consumerd64-bin=3D<lttng_install_root>/lib64/lttng/libexec/lttng-con=
sumerd.
I think, this did the trick (if I remember correctly).

--
Paul

>
>> BTW, when you compile for the "-m32" multilib, it's better to use the fo=
llowing:
>> $ ./configure CC=3D"gcc -m32"
>> This way also the linking steps (performed by libtool) of your build wil=
l know that you are building for m32 (on your x86_64 system) and you don't =
need e.g. "--libdir ....".
>    That's what I did, but I still felt I needed to specify libdir so the =
install did not overwrite the 64-bit libraries (liblttng-ctl.so, liblttng-u=
st.so, etc.).
>
>> For more information see:
>> http://doc.opensuse.org/documentation/html/openSUSE/opensuse-reference/c=
ha.64bit.html#sec.64bit.biarch
>> or
>> https://developer.mozilla.org/en/docs/Compiling_32-bit_Firefox_on_a_Linu=
x_64-bit_OS
>    I have seen the second one, which was moderately useul.  I'll look int=
o the first one, thanks.
>
>>> More generally, how does one add tracepoints to a 32-bit application ru=
nning on a 64-bit system?
>> You simply compile your instrumented application to 32-bit the same way =
you did it for the lttng-ust package (CC=3D"gcc -m32").
>>
>> Paul Woegerer, SW Development Engineer
>    Indeed, once lttng-ust has been done in 32-bits, I can use the 'make s=
tatic32' I quoted at the beginning of the thread like this:
>
> $ LDFLAGS=3D-L/usr/local/lib32 make static 32
>
>    And then run the sample app like this:
>
> $ LD_PRELOAD=3D/usr/local/lib32/liblttng-ust.so ./sample_static32
>
>    (I could dump the LD_PRELOAD by adding /usr/local/lib32 to my PATH)
>
>    But my running lttng-sessiond (enable-event -u -a) complains:
>
> Error: Consumer socket fd -1 not found in consumer obj 0x7ffd4000b650
>
>    My guess is I'll need to launch lttng-sessiond with the -u and -U opti=
ons to point it to the 32-bit lttng-consumerd...Once I can get the 32-bit l=
ttng-tools to compile and install it.
>
> Daniel U. Thibault
> Protection des syst=E8mes et contremesures (PSC) | Systems Protection & C=
ountermeasures (SPC)
> Cyber s=E9curit=E9 pour les missions essentielles (CME) | Mission Critica=
l Cyber Security (MCCS)
> R & D pour la d=E9fense Canada - Valcartier (RDDC Valcartier) | Defence R=
&D Canada - Valcartier (DRDC Valcartier)
> 2459 route de la Bravoure
> Qu=E9bec QC  G3J 1X5
> CANADA
> Vox : (418) 844-4000 x4245
> Fax : (418) 844-4538
> NAC : 918V QSDJ <http://www.travelgis.com/map.asp?addr=3D918V%20QSDJ>
> Gouvernement du Canada | Government of Canada
> <http://www.valcartier.drdc-rddc.gc.ca/>


-- =

Paul Woegerer, SW Development Engineer
Sourcery Analyzer <http://go.mentor.com/sourceryanalyzer>
Mentor Graphics, Embedded Software Division
