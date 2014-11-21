From: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Subject: Re: Question about TRACEPOINT_EVENT_CLASS and
 TRACEPOINT_EVENT_INSTANCE
Date: Fri, 21 Nov 2014 15:19:52 +0000
Message-ID: <48CF5AC71E61DB46B70D0F388054EFFD6FBC9442__5859.05568809739$1416583243$gmane$org@VAL-E-02.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from fw.drenet.dnd.ca ([131.136.242.1] helo=mx.drdc-rddc.gc.ca)
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <Daniel.Thibault@drdc-rddc.gc.ca>) id 1Xrq06-0007KI-9U
 for lttng-dev@lists.lttng.org; Fri, 21 Nov 2014 10:20:04 -0500
Content-Language: fr-FR
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

----------------------------------------------------------------------
Date: Fri, 21 Nov 2014 15:28:30 +0400
From: Eugene Ivanov <eiva@tbricks.com>

>>    Normally you use TRACEPOINT_EVENT_CLASS and _INSTANCE within the same
>> provider, but you could theoretically have varying instances rely on
>> different providers.  I guess this would allow you some flexibility in
>> picking which sets of instances to enable/disable by picking which provi=
der
>> shared objects (.so) to preload or not.
>
>Thanks for the explanation, Daniel! Unfortunately using class defined in
>another provider doesn't work. I get an error about undefined
>__event_probe__instance_provider_name___class_name_from_another_provider?.
>Connecting it with your description, I guess it's probably a feature and
>intended behaviour. Though it would be a nice feature to be able to specify
>provider of class separately from provider of instance.

   Would LTTng-delvers more versed in these innards care to comment on the =
following?

   If the provider argument to the macros is not intended to ever point at =
anything else than the provider block it is declared in (the #define TRACEP=
OINT_PROVIDER line), this should be documented and ideally the macros shoul=
d hide this implicit argument.

   On the other hand, if the intent is to allow cross-provider usage of som=
e form, this also needs to be documented.  What is the recipe supposed to b=
e?

Daniel U. Thibault
Protection des syst=E8mes et contremesures (PSC) | Systems Protection & Cou=
ntermeasures (SPC)
Cyber s=E9curit=E9 pour les missions essentielles (CME) | Mission Critical =
Cyber Security (MCCS)
RDDC - Centre de recherches de Valcartier | DRDC - Valcartier Research Cent=
re
2459 route de la Bravoure
Qu=E9bec QC  G3J 1X5
CANADA
Vox : (418) 844-4000 x4245
Fax : (418) 844-4538
NAC : 918V QSDJ <http://www.travelgis.com/map.asp?addr=3D918V%20QSDJ>
Gouvernement du Canada | Government of Canada
<http://www.valcartier.drdc-rddc.gc.ca/>
