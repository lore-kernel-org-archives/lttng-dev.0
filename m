From: Jesper Derehag <jderehag@hotmail.com>
Subject: FW:  relayd TCP reconnect?
Date: Thu, 26 Mar 2015 08:21:34 +0000
Message-ID: <DUB123-W14A30EB76E6C3369DA78CEDD080__45485.4031828747$1427358167$gmane$org@phx.gbl>
References: <DUB123-W281E1610272EFEB7FEBDA2DD0B0@phx.gbl>,
 <CA+jJMxvqgcwouaAyAEty9Ghd3hkd5N0PdFZOuR1s9j-d0RCO-A@mail.gmail.com>,
 <DUB123-W398B9D56C2EA95095578ECDD080@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from dub004-omc3s33.hotmail.com ([157.55.2.42])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jderehag@hotmail.com>) id 1Yb32q-0002Xs-Q7
 for lttng-dev@lists.lttng.org; Thu, 26 Mar 2015 04:21:43 -0400
In-Reply-To: <DUB123-W398B9D56C2EA95095578ECDD080@phx.gbl>
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

Forwarding to lttng-dev as well..

----------------------------------------
> From: jderehag@hotmail.com
> To: jeremie.galarneau@efficios.com
> Subject: RE: [lttng-dev] relayd TCP reconnect?
> Date: Thu, 26 Mar 2015 08:20:52 +0000
>
> Great, added new RM issue:
> https://bugs.lttng.org/issues/883
>
> Thanks!
> /Jesper
>
> ----------------------------------------
>> Date: Wed, 25 Mar 2015 14:14:27 -0400
>> Subject: Re: [lttng-dev] relayd TCP reconnect?
>> From: jeremie.galarneau@efficios.com
>> To: jderehag@hotmail.com
>> CC: lttng-dev@lists.lttng.org
>>
>> On Wed, Mar 25, 2015 at 11:16 AM, Jesper Derehag <jderehag@hotmail.com> =
wrote:
>>> Hi All,
>>>
>>> I know the issue with relayd reconnects have been discussed earlier her=
e:
>>> http://lists.lttng.org/pipermail/lttng-dev/2014-October/023650.html
>>>
>>> But has there been any further development on this?
>>> I would actually go as far as calling it a bug and submitting it to red=
mine tracker, but want to get approval here first.
>>>
>>
>> Hi Jesper,
>>
>> There has been no work done on this yet.
>>
>>> I would argue that its *always* a good idea to do reconnects due to tha=
t you really dont have any end-to-end control of the TCP flow.
>>> Some random router might decide to spuriously drop your connection, not=
 to mention more modern queuing disciplines which might randomly throw away=
 packets.
>>>
>>> On automated systems, that would mean that you have to somehow automagi=
cally detect that you got a disconnect, and then externally restart the ses=
sion, which seems like a very weird workaround...
>>>
>>> I would be happy to file such a issue to the tracker if people thinks i=
ts a good idea, (and depending on if I have the time I *might* look into so=
lving it myself).
>>> But it might be some time away in that case..
>>
>> Sure, feel free to open a ticket. We'll definitively have to look into
>> recovering gracefully at some point.
>>
>> J=E9r=E9mie
>>
>>>
>>> Regards,
>>> Jesper
>>>
>>>
>>>
>>> _______________________________________________
>>> lttng-dev mailing list
>>> lttng-dev@lists.lttng.org
>>> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>>
>>
>>
>> --
>> J=E9r=E9mie Galarneau
>> EfficiOS Inc.
>> http://www.efficios.com
>
 		 	   		  =
