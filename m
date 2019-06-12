From: He Zhe <zhe.he-CWA4WttNNZF54TAoqtyWWQ@public.gmane.org>
Subject: Re: [PATCH v2] lttng-modules: Backport patches to fix
 compilation failures since kernel v5.1
Date: Wed, 12 Jun 2019 20:32:38 +0800
Message-ID: <bdec2cee-1c75-1673-86ca-d4b455b0c5aa@windriver.com>
References: <1560243834-266906-1-git-send-email-zhe.he@windriver.com>
	<be27377cd254f6b314185702300d051d20fb7c28.camel@linuxfoundation.org>
	<20190612105114.GA23143@localhost>
	<1859381600.42862.1560337102909.JavaMail.zimbra@efficios.com>
	<0ea3a599-7adb-a001-dbdd-3843d0fa8b6e@windriver.com>
	<928433718.42889.1560338990358.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <openembedded-core-bounces-ZwoEplunGu3dfDuKDZ/zN51Ccm5ICvs9@public.gmane.org>
In-Reply-To: <928433718.42889.1560338990358.JavaMail.zimbra-vg+e7yoeK/dWk0Htik3J/w@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/openembedded-core>,
	<mailto:openembedded-core-request-ZwoEplunGu3dfDuKDZ/zN51Ccm5ICvs9@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/openembedded-core/>
List-Post: <mailto:openembedded-core-ZwoEplunGu3dfDuKDZ/zN51Ccm5ICvs9@public.gmane.org>
List-Help: <mailto:openembedded-core-request-ZwoEplunGu3dfDuKDZ/zN51Ccm5ICvs9@public.gmane.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/openembedded-core>,
	<mailto:openembedded-core-request-ZwoEplunGu3dfDuKDZ/zN51Ccm5ICvs9@public.gmane.org?subject=subscribe>
Sender: openembedded-core-bounces-ZwoEplunGu3dfDuKDZ/zN51Ccm5ICvs9@public.gmane.org
Errors-To: openembedded-core-bounces-ZwoEplunGu3dfDuKDZ/zN51Ccm5ICvs9@public.gmane.org
To: Mathieu Desnoyers <mathieu.desnoyers-vg+e7yoeK/dWk0Htik3J/w@public.gmane.org>
Cc: openembedded-core <openembedded-core-ZwoEplunGu3dfDuKDZ/zN51Ccm5ICvs9@public.gmane.org>, Jeremie Galarneau <jgalar-vg+e7yoeK/dWk0Htik3J/w@public.gmane.org>, lttng-dev <lttng-dev-bnB2LGs2QVJ+nrgayQ7rhA@public.gmane.org>, Adrian Bunk <bunk-HeJ8Db2Gnd6zQB+pC5nmwQ@public.gmane.org>
List-Id: lttng-dev@lists.lttng.org



On 6/12/19 7:29 PM, Mathieu Desnoyers wrote:
> ----- On Jun 12, 2019, at 1:10 PM, zhe he zhe.he-CWA4WttNNZF54TAoqtyWWQ@public.gmane.org wrote:
>
>> On 6/12/19 6:58 PM, Mathieu Desnoyers wrote:
>>> ----- On Jun 12, 2019, at 12:51 PM, Adrian Bunk bunk-HeJ8Db2Gnd6zQB+pC5nmwQ@public.gmane.org wrote:
>>>
>>>> On Tue, Jun 11, 2019 at 11:49:34PM +0100, Richard Purdie wrote:
>>>>> On Tue, 2019-06-11 at 17:03 +0800, zhe.he-CWA4WttNNZF54TAoqtyWWQ@public.gmane.org wrote:
>>>>>> From: He Zhe <zhe.he-CWA4WttNNZF54TAoqtyWWQ@public.gmane.org>
>>>>>>
>>>>>> For the moment,
>>>>>> 0001~0004 are on master branch only.
>>>>>> 0005~0007 are on stable-2.11 branch, but v2.11 has not been released
>>>>>> yet.
>>>>>>
>>>>>> Signed-off-by: He Zhe <zhe.he-CWA4WttNNZF54TAoqtyWWQ@public.gmane.org>
>>>>>> ---
>>>>>> v2: Correct a typo in SOB for 0001*.patch
>>>>> I just discussed this with lttng upstream maintainers a little. We're
>>>>> going to have continual tension between keeping lttng-modules up to
>>>>> date and new kernel versions.
>>>>>
>>>>> How about we also have a git version of this particular recipe which
>>>>> has a DEFAULT_PREFERENCE = "-1" but people can opt into with a
>>>>> PREFERRED_VERSION when using newer kernels?
>>>> Yocto stable series will ship a _git AUTOREV recipe?
>>>>
>>>>> That should keep people using very recent kernels happy, let us use a
>>>>> stable release version and avoid us adding/removing large patchsets on
>>>>> a semi regular basis?
>>>>> ...
>>>> The semi regular basis is only slightly moved, or how and when will
>>>> replacing the already EOL kernel 5.0 with 5.1 in Yocto be handled?
>>>>
>>>> IMHO it would be better to acknowledge that this is a case where staying
>>>> at stable release versions is sometimes not the best option, and upgrade
>>>> the normal recipe to -rc releases or even a git snapshot from a more
>>>> recent stable branch when necessary.
>>>>
>>>> E.g. right now it seems clear that the next Yocto release will have
>>>> to use lttng-modules >= 2.11 in any case for kernel 5.2, so upgrading
>>>> from 2.10.9 to 2.11.0-rc5 would be logical.
>>> Please don't base distributions on -rc tags. They are not meant for this.
>>>
>>> We always integrate support for newer kernel versions instrumentation back
>>> into our current stable release. So as soon as 5.2 final comes out, we will
>>> release a 2.10.x version including support for it in lttng-modules.
>> I'm one of the people who need to use lttng-modules on rc kernel.
>>
>>> The current 2.10.10 has commits to support the currently known 5.2-rc
>>> instrumentation changes.
>> Seems v2.10.10 does not contains the 7 needed patches in my v1 for kernel v5.0+.
>> $ git pull
>> Already up-to-date.
>> $ git tag|grep v2.10.10
>> v2.10.10
>> $ git tag --contains 92da05ce1f73488a57e7fd79e9c03113cefdb76f
>> $ git tag --contains d88e2fe5c3ea0d2c3055fba824be17223c418854
>> $ git tag --contains d6cd2c9598a06f0ba1ba885bbe754e8836528310
>> $ git tag --contains 2ca0c84f0b4a915c555a0b83102d94ac941619ca
>> $ git tag --contains da00122ccfae6a73ec859826a0be1cf0902cfd11
>> v2.11.0-rc5
>> $ git tag --contains da00122ccfae6a73ec859826a0be1cf0902cfd11
>> v2.11.0-rc5
>> $ git tag --contains df0e746a05a267384785d66c9fca947eb4a9e517
>> v2.11.0-rc5
>> $ git tag --contains 9f70b60c19abc6dc0811e427ed5da4aa74620aca
>> v2.11.0-rc5
> You're aware that the commit ID changes when we cherry-pick
> a commit right ?
>
> Please double-check with the commit names...

Sorry, my mistake. They've been there.

Zhe

>
> Thanks,
>
> Mathieu
>
>
>> Thanks,
>> Zhe
>>
>>> Thanks,
>>>
>>> Mathieu
>>>
>>>
>>>>> Cheers,
>>>>>
>>>>> Richard
>>>> cu
>>>> Adrian
>>>>
>>>> --
>>>>
>>>>       "Is there not promise of rain?" Ling Tan asked suddenly out
>>>>        of the darkness. There had been need of rain for many days.
>>>>       "Only a promise," Lao Er said.
>>>>                                        Pearl S. Buck - Dragon Seed

-- 
