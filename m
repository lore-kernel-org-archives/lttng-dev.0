From: =?ISO-8859-1?Q?J=E9r=E9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: Trace rotation across sessions
Date: Tue, 18 Mar 2014 10:42:32 -0400
Message-ID: <CA+jJMxvu2t0+83H6QyRLPdg_vZmiwQ3XTahCaEYapKwm5a0eSA__16953.7575370216$1395153834$gmane$org@mail.gmail.com>
References: <OFBBFCF198.C68E7A66-ONC2257C9F.00309BBF-C2257C9F.0030CCEA@il.ibm.com>
	<CA+jJMxsBWqc24+ib8QVmTzx85PG6eXkGYOHD5=6R2ehRUCBzOw@mail.gmail.com>
	<OF08BD8E32.191B0BC5-ONC2257C9F.004F7CAC-C2257C9F.004F942B@il.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qg0-f47.google.com ([209.85.192.47])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jeremie.galarneau@gmail.com>) id 1WPvDx-0002Bo-Ki
	for lttng-dev@lists.lttng.org; Tue, 18 Mar 2014 10:42:43 -0400
Received: by mail-qg0-f47.google.com with SMTP id 63so4865875qgz.6
	for <lttng-dev@lists.lttng.org>; Tue, 18 Mar 2014 07:42:32 -0700 (PDT)
In-Reply-To: <OF08BD8E32.191B0BC5-ONC2257C9F.004F7CAC-C2257C9F.004F942B@il.ibm.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Amit Margalit <AMITM@il.ibm.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

On Tue, Mar 18, 2014 at 10:28 AM, Amit Margalit <AMITM@il.ibm.com> wrote:
> It may be what I am looking for.
>
> Are you saying that lttng-sessiond will pick up the session from whereever
> it is and continue it?

No. As far as I know, the session daemon will simply overwrite the files.

J=E9r=E9mie

>
> BTW, I am using only UST for now.
>
> Amit Margalit
> IBM XIV - Storage Reinvented
> XIV-NAS Development Team
> Tel. 03-689-7774
> Fax. 03-689-7230
>
>
>
> From:        J=E9r=E9mie Galarneau <jeremie.galarneau@efficios.com>
> To:        Amit Margalit/Israel/IBM@IBMIL
> Cc:        lttng-dev <lttng-dev@lists.lttng.org>
> Date:        03/18/2014 04:19 PM
> Subject:        Re: [lttng-dev] Trace rotation across sessions
> Sent by:        jeremie.galarneau@gmail.com
> ________________________________
>
>
>
> On Tue, Mar 18, 2014 at 4:52 AM, Amit Margalit <AMITM@il.ibm.com> wrote:
>> Hello,
>>
>> Our system has a running session that stays on continuously.
>>
>> Occasionally, our customer will upgrade the software, leading to a reboo=
t,
>> which in turn means we will have a new session.
>>
>> Is there any way to make LTTng aware of the total size of all sessions
>> (current and past) and simply rotate files to keep the entire set of
>> traces
>> under a size limit?
>>
>
> The only way I can see this working is by recreating the same session
> configuration (with the same output destination) and using lttng
> enable-channel's -C (tracefile-size) and -W (tracefile-count) options
> to define an upper bound on each trace's size.
>
> Is this what you are looking for?
>
> J=E9r=E9mie
>
>> Thanks,
>>
>> Amit Margalit
>> IBM XIV - Storage Reinvented
>> XIV-NAS Development Team
>> Tel. 03-689-7774
>> Fax. 03-689-7230
>> _______________________________________________
>> lttng-dev mailing list
>> lttng-dev@lists.lttng.org
>> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>>
>
>
>
> --
> J=E9r=E9mie Galarneau
> EfficiOS Inc.
> http://www.efficios.com
>
>



-- =

J=E9r=E9mie Galarneau
EfficiOS Inc.
http://www.efficios.com
