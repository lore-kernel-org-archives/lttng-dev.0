From: Alexandre Montplaisir <alexmonthy@voxpopuli.im>
Subject: Re: [PATCH lttng-tool] Mi & save/load: add option to
 indent or not on config writer creation
Date: Thu, 07 Aug 2014 11:47:59 -0400
Message-ID: <53E39FAF.9060904__43918.1011556231$1407426532$gmane$org@voxpopuli.im>
References: <48CF5AC71E61DB46B70D0F388054EFFD3CCB4810@VAL-E-01.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; Format="flowed"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from ironport2-out.teksavvy.com ([206.248.154.181])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <alexmonthy@voxpopuli.im>) id 1XFPv6-00017A-PA
 for lttng-dev@lists.lttng.org; Thu, 07 Aug 2014 11:48:02 -0400
In-Reply-To: <48CF5AC71E61DB46B70D0F388054EFFD3CCB4810@VAL-E-01.valcartier.drdc-rddc.gc.ca>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>, "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

I was expecting Jonathan to explain it further in his upcoming reply ;)

But from the numbers I've seen from his benchmark, it was overall 50 =

times faster when using the minified XML than using the "pretty-printed" =

one.
Mainly from:
- Not having to concatenate all the outputted strings into one
- Not having to iterate (MANY times) on empty XML nodes

Cheers,
Alexandre

On 08/07/2014 09:09 AM, Thibault, Daniel wrote:
> ----------------------------------------------------------------------
> Date: Wed, 06 Aug 2014 11:34:39 -0400
> From: Alexandre Montplaisir <alexmonthy@voxpopuli.im>
> To: Simon Marchi <simon.marchi@polymtl.ca>,  Jonathan Rajotte Julien <jon=
athan.r.julien@gmail.com>
>
> On 08/06/2014 10:49 AM, Simon Marchi wrote:
>> Just by curiosity, did you manage to put a number on that performance im=
pact?
> 50
> ----------------------------------------------------------------------
>
>     Fifty what?  Furlongs per fortnight?  If dimensionless, what is it?
>
> Daniel U. Thibault
> Protection des syst=E8mes et contremesures (PSC) | Systems Protection & C=
ountermeasures (SPC)
> Cyber s=E9curit=E9 pour les missions essentielles (CME) | Mission Critica=
l Cyber Security (MCCS)
> RDDC - Centre de recherches de Valcartier | DRDC - Valcartier Research Ce=
ntre
> 2459 route de la Bravoure
> Qu=E9bec QC  G3J 1X5
> CANADA
> Vox : (418) 844-4000 x4245
> Fax : (418) 844-4538
> NAC : 918V QSDJ <http://www.travelgis.com/map.asp?addr=3D918V%20QSDJ>
> Gouvernement du Canada | Government of Canada
> <http://www.valcartier.drdc-rddc.gc.ca/>
