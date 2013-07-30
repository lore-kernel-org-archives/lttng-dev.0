From: =?ISO-8859-1?Q?J=E9r=E9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: lttng Crash seen after stopping the traces.
Date: Tue, 30 Jul 2013 10:28:20 -0400
Message-ID: <CA+jJMxvMBPOaxJJph0ht9SFUbywYRezWHgHncxQDiyR+pM6EGw__22255.7936482646$1375194572$gmane$org@mail.gmail.com>
References: <CAJD=Q56dkx1jCUF0n03XFCs64hFmuDYELy+FVF9joZ8nxDUpDw@mail.gmail.com>
	<CA+jJMxt0kJJv2F26Myzcvms_6tSXAo269Zg5fMXyeXEn5eH95A@mail.gmail.com>
	<CAJD=Q56myG=OuBXv2At2NEB0eqXOqjtTqVAMA5SZf2BgmmZ3Cg@mail.gmail.com>
	<CAJD=Q56CFSqfjGqiGUMN+Zq4WCFomuBNwbvGi=oTMjWM1hNZOA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-wi0-f169.google.com ([209.85.212.169])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jeremie.galarneau@gmail.com>) id 1V4AuY-0002GS-Vg
	for lttng-dev@lists.lttng.org; Tue, 30 Jul 2013 10:28:34 -0400
Received: by mail-wi0-f169.google.com with SMTP id f14so2188802wiw.0
	for <lttng-dev@lists.lttng.org>; Tue, 30 Jul 2013 07:28:21 -0700 (PDT)
In-Reply-To: <CAJD=Q56CFSqfjGqiGUMN+Zq4WCFomuBNwbvGi=oTMjWM1hNZOA@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Jonnavithula Sharma <sarmajprs@gmail.com>
Cc: lttng-dev@lists.lttng.org, suprasad.desai@gmail.com
List-Id: lttng-dev@lists.lttng.org

Can you open a new issue on the bug tracker? [1]

Please make sure you include your kernel version, details about your
target's architecture and the logs you posted.

Thanks,
J=E9r=E9mie

[1] https://bugs.lttng.org/projects/lttng-modules

On Tue, Jul 30, 2013 at 5:39 AM, Jonnavithula Sharma
<sarmajprs@gmail.com> wrote:
> Sorry.Missed the attachment in previous mail.Enclosed here is the console
> log for the crash with lttng-modules 2.2.1.
>
> Regards,
> Sarma  j
>
>
> On Tue, Jul 30, 2013 at 11:08 AM, Jonnavithula Sharma <sarmajprs@gmail.co=
m>
> wrote:
>>
>> Hi Jeremie,
>>
>> We tried with the latest version(2.2.1) of lttng-modules. We are able to
>> reproduce the same crash with the same steps.
>>
>> Am i missing anything here?
>>
>> Regards,
>> Sarma J
>>
>>
>> On Mon, Jul 29, 2013 at 9:05 PM, J=E9r=E9mie Galarneau
>> <jeremie.galarneau@efficios.com> wrote:
>>>
>>> Hi,
>>>
>>> Can you try to reproduce the problem with the latest version of
>>> lttng-modules (v2.2.1)? There were some bug fixes to the ring buffer
>>> that may correct your problem.
>>>
>>> Thanks for reporting,
>>> J=E9r=E9mie
>>>
>>> On Mon, Jul 29, 2013 at 9:45 AM, Jonnavithula Sharma
>>> <sarmajprs@gmail.com> wrote:
>>> > Hi
>>> >
>>> > We are currently running lttng on our CPE with 64 MB RAM.We are
>>> > observing a
>>> > crash after stopping the traces and even if we leave our CPE for few
>>> > min
>>> > after starting the trace we are observing this crash.Please find the
>>> > attachment for the crash log.
>>> >
>>> > Let us know if any one has faced this issue and your help is highly
>>> > appreciated in resolving this issue.
>>> >
>>> >
>>> > Regards,
>>> > Sarma J
>>> >
>>> > _______________________________________________
>>> > lttng-dev mailing list
>>> > lttng-dev@lists.lttng.org
>>> > http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>>> >
>>>
>>>
>>>
>>> --
>>> J=E9r=E9mie Galarneau
>>> EfficiOS Inc.
>>> http://www.efficios.com
>>
>>
>



-- =

J=E9r=E9mie Galarneau
EfficiOS Inc.
http://www.efficios.com
