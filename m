From: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Subject: Re: [RFC Patch Ust 2/5] Serialize the CTF global
 structures for ust-comm
Date: Fri, 2 May 2014 13:40:32 +0000
Message-ID: <48CF5AC71E61DB46B70D0F388054EFFD3599E866__25336.6929865026$1399038106$gmane$org@VAL-E-01.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from fw.drenet.dnd.ca ([131.136.242.1] helo=mx.drdc-rddc.gc.ca)
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <Daniel.Thibault@drdc-rddc.gc.ca>) id 1WgDhf-0003Jb-6F
 for lttng-dev@lists.lttng.org; Fri, 02 May 2014 09:40:45 -0400
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
> Date: Fri, 2 May 2014 09:29:09 +0000 (UTC)
> From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> To: Genevi=E8ve Bastien <gbastien+lttng@versatic.net>

> Yes, all this is about not repeating global type descriptions over the Un=
ix socket between applications and session daemon.
>
> The issue here is that with the current approach, we have to repeat possi=
bly very long descriptions of structures, variants, and enums because they =
need to be bundled after every event description.
>
> Here is what I would envision instead:
>
> - We add a "global type" notifier to the UST notifiers (there is currentl=
y only "event" and "channel"). Those notifiers are sending the descriptions
>   of channels and events as seen from within the application to lttng-ses=
siond, so it can put it in its ust registry to later generate
>   the metadata.
> - Those notifiers can be used to send descriptions of enums, structs, and=
 variants.
> - We'll probably want to have some way of verifying if the global type is=
 exactly the same as global types with the same provider and
>   global type names registered previously, thus dealing with different pr=
ovider .so versions, each containing different versions of the global
>   type. We'll have to find out what's the behaviour when this check does =
not succeed (failure or versioning of the global type within sessiond ?).
>   This verification will be needed once per global type, per application =
process. This verification needs to be done by sending the provider and
>   global type name, along with the global type details (to see if it matc=
hes).
> - Per global type, per application, we can keep a flag that knows whether=
 the global type description has been successfully sent to the session
>   daemon for each session.

   I'd strongly advise to go the versioning way rather than the failure way=
 (although failure is easier to implement initially).  The verification nee=
ds to be done more often than "once per global type, per application proces=
s": one use case is a process that dynamically loads (dlopen) an instrument=
ed .so, generates events with it for a while, then unloads it (dlclose) and=
 loads another .so that happens to include a provider with the same signatu=
re but different event payloads.  The process may or may not wholly unregis=
ter from and re-register with the session manager, depending on whether or =
not it has other providers loaded.

   See the closely related bugs #561, #698, #720.

   If the bandwidth used in sending lengthy type descriptions for mere veri=
fication is a concern, maybe the conversation between the app tracepoint pr=
ovider and session manager could start by sending an MD5 or SHA hash of the=
 type description.  Only when those mismatch would the full type descriptio=
n need to be sent.

   Also note that event type verification can be "lazy" (or "delayed") and =
occur only when the event type in question is actually enabled or emitted. =
 There isn't much point to updating the trace metadata with changing event =
types if the events in question are not enabled (at the channel or event le=
vel).  On the other hand, sending a filter specification to a provider pret=
ty much requires event type verification, if only to warn the user that the=
 filter he specified for the event won't be understood by the provider.

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
