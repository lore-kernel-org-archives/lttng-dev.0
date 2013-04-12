From: =?ISO-8859-1?Q?J=E9r=E9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: GSoC 2013,
 "Instrumenting Open Source projects using UST" project.
Date: Fri, 12 Apr 2013 12:39:44 -0400
Message-ID: <CA+jJMxsvfgEUfCFLoKO=XCdG04bb4F=0Xa9V7RHbBf1EYLspdg__29430.1786031157$1365784817$gmane$org@mail.gmail.com>
References: <CAL_rx6WAZFhUdD2ytRXk9NOJb-=wLmBsE_dfAX+MpxSyVKh2Tg@mail.gmail.com>
	<CAGDH53n5KcVOtO9QukPWycCr7vSf4ybzxneriaEMv0u-VN2Z6g@mail.gmail.com>
	<CAGDH53=JTgKVHwdvK4yjjuNXTWbm1BQXMPbn+kEnaOvnuLyJ8g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-wi0-f180.google.com ([209.85.212.180])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jeremie.galarneau@gmail.com>) id 1UQh0w-0004Ll-F2
	for lttng-dev@lists.lttng.org; Fri, 12 Apr 2013 12:39:50 -0400
Received: by mail-wi0-f180.google.com with SMTP id c10so1780803wiw.7
	for <lttng-dev@lists.lttng.org>; Fri, 12 Apr 2013 09:39:44 -0700 (PDT)
In-Reply-To: <CAGDH53=JTgKVHwdvK4yjjuNXTWbm1BQXMPbn+kEnaOvnuLyJ8g@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Christian Babeux <christian.babeux@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

That certainly is an interesting project!

You should probably approach the subject with the wpa_supplicant's
developers to gauge their interest in integrating UST tracepoints into
their codebase. I have never looked at their code; maybe they already
have a logging or tracing infrastructure in place which would make the
modifications less invasive.

This, of course, applies to any project you'd like to instrument.
Determining the developers' level of interest in LTTng is a crucial
part of such proposals since we don't want to maintain patchsets for
external projects (at least, I'd advocate against it).

Looking forward to hearing from you,
J=E9r=E9mie

On Fri, Apr 12, 2013 at 12:10 PM, Christian Babeux
<christian.babeux@efficios.com> wrote:
> Reply from Tabibel Sami:
>
> ---------- Forwarded message ----------
> From: Tabibel Sami <sami.tabibel@gmail.com>
> Date: Fri, Apr 12, 2013 at 11:59 AM
> Subject: Re: [lttng-dev] GSoC 2013, "Instrumenting Open Source
> projects using UST" project.
> To: Christian Babeux <christian.babeux@efficios.com>
>
>
> On Fri, Apr 12, 2013 at 5:48 PM, Christian Babeux
> <christian.babeux@efficios.com> wrote:
>> Hi,
>>
>> Do you have a specific open-source project in mind that you would like
>> to instrument with LTTng?
>
> I have studied little of wpa_supplicant source code lately, I
> understand a little of its operation Principe, I have some backgrounds
> on 802.1x authentication. and i am khow working on implementation of
> EAP-SIM supplicant, It will be good thing if i can work on this
> software .
>
>> Instrumenting should be straightforward (add tracepoints to the
>> application source code), the challenge will reside in finding the
>> appropriates sites to instruments to get useful data out of the
>> application.
>>
>> Thanks,
>>
> Thanks
> Regards!
> --
> Sami
>
> On Fri, Apr 12, 2013 at 11:48 AM, Christian Babeux
> <christian.babeux@efficios.com> wrote:
>> Hi,
>>
>> Do you have a specific open-source project in mind that you would like
>> to instrument with LTTng?
>>
>> Instrumenting should be straightforward (add tracepoints to the
>> application source code), the challenge will reside in finding the
>> appropriates sites to instruments to get useful data out of the
>> application.
>>
>> Thanks,
>>
>> Christian
>>
>> On Tue, Apr 9, 2013 at 10:20 PM, Tabibel Sami <sami.tabibel@gmail.com> w=
rote:
>>> Hello,
>>> I am doing master degree of Cryptology and information security
>>> I have good C, Python and Scapy skills, and i am interested to work on
>>> "Instrumenting Open Source projects using UST" project this summer.
>>>
>>> I am looking for any comment about the difficulty and the content of
>>> the project, and also about my chances to be accepted if i apply for.
>>>
>>> Thanks in advance.
>>> Best Regards.
>>>
>>> _______________________________________________
>>> lttng-dev mailing list
>>> lttng-dev@lists.lttng.org
>>> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev



-- =

J=E9r=E9mie Galarneau
EfficiOS Inc.
http://www.efficios.com
