From: David Goulet <dgoulet@efficios.com>
Subject: Re: [LTTNG-TOOLS PATCH v2] ABI with support for compat
 32/64 bits
Date: Mon, 01 Oct 2012 14:43:41 -0400
Message-ID: <5069E45D.4040303__30527.6293111548$1349117058$gmane$org@efficios.com>
References: <1348952028-31926-1-git-send-email-jdesfossez@efficios.com>
	<20121001161541.GB14260@Krystal> <5069D90C.1030804@efficios.com>
	<20121001181452.GA15644@Krystal>
	<5069DF8F.9050706@efficios.com> <5069E352.7040909@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([213.239.202.151])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <dgoulet@efficios.com>) id 1TIkxz-0000Wo-VH
	for lttng-dev@lists.lttng.org; Mon, 01 Oct 2012 14:43:44 -0400
In-Reply-To: <5069E352.7040909@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Julien Desfossez <jdesfossez@efficios.com>
Cc: lttng-dev@lists.lttng.org, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
List-Id: lttng-dev@lists.lttng.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512



Julien Desfossez:
>>>>>> 
>>>>>> +/* + * This flag indicates if lttng-tools must use the
>>>>>> new or the old kernel ABI + * (without compat support for
>>>>>> 32/64 bits). It is set by + * kernctl_tracer_version()
>>>>> 
>>>>> Hrm. I don't like that this is only set by 
>>>>> kernctl_tracer_version(). What if, for an unforeseen
>>>>> reason (e.g. code change), sessiond starts using "create
>>>>> session" before checking the version ? The change you
>>>>> propose assumes a behavior on the sessiond side that is not
>>>>> cast in stone (no ABI requires it), so it might change.
>>>>> This brings coupling between this otherwise self-contained
>>>>> wrapper and the entire sessiond code base, which I don't
>>>>> like.
>>>>> 
>>>>> We should put the check in a wrapper macro around the every
>>>>> new ioctl call.
>>>>> 
>>>>> e.g.
>>>>> 
>>>>> /* * Cache whether we need to use the old or new ABI. */
>>>>> static lttng_kernel_use_old_abi = -1;
>>>>> 
>>>>> 
>>>>> if (lttng_kernel_use_old_abi == -1) { ret = ioctl(fd,
>>>>> newname, args); if (!ret) { lttng_kernel_use_old_abi = 0; }
>>>>> } else { if (!lttng_kernel_use_old_abi) { ret = ioctl(fd,
>>>>> oldname, args); } else { ret = ioctl(fd, newname, args); }
>>>>> } return ret;
>>>>> 
>>>>> Thoughts ?
>>>> 
>>>> Ok I will add this wrapper, I am wondering if we could just
>>>> limit to these ioctl since they are the only one called on
>>>> the "top-level" fd (/proc/lttng) instead of adding it
>>>> everywhere : LTTNG_KERNEL_SESSION LTTNG_KERNEL_TRACER_VERSION
>>>>  LTTNG_KERNEL_TRACEPOINT_LIST LTTNG_KERNEL_WAIT_QUIESCENT 
>>>> LTTNG_KERNEL_CALIBRATE
>>>> 
>>>> All other ioctl require at least a session so is it OK if I
>>>> limit the test to only these ?
>> 
>>> yes, it makes sense. And given that this code is very much 
>>> localized, I don't think it would be worth the effort to create
>>> a macro wrapper. Duplicating the checks at each 5 sites, all
>>> within the same file, seems good enough. But it's David's
>>> call.
>> 
>> I don't know... I can easily see some other use cases in the
>> future that requires us to wrap the ioctl according to the
>> kernel.
>> 
>> I remember having this discussion way back when we started
>> lttng-tools code and here we are almost three years later fixing
>> the "ioctl wrapper issue" :P.
>> 
>> I don't think adding a macro is a lot of work and it will be
>> really easier for us to scale and adapt over time. Please, if I'm
>> wrong, speak now or shut up to the end of eternity! :P
> 
> For this particular case, we need to make special treatment when
> the ioctl takes an argument depending on the ABI version (alloc and
> assign the old struct values from the new one), so we won't be able
> to call a generic wrapper (except if we do this treatment all the
> time which I doubt we want). For ioctls that don't take an argument
> the wrapper is easy though.
> 
> So I think I should do a wrapper like compat_ioctl_no_arg(int fd,
> unsigned long oldname, unsigned long newname) and for the ioctls
> that take an argument make the checks locally.

Hmmm it's that or a compat call for each ioctl listed above... or
using va_list but I really don't like that :P

Either way works for me. Mathieu?

David

> 
> Thoughts ?
> 
> Thanks,
> 
> Julien
> 
> 
-----BEGIN PGP SIGNATURE-----

iQEcBAEBCgAGBQJQaeRaAAoJEELoaioR9I026m4IALHDYyU28segZJpauX6JbDTE
ij+T9aW7+bAxJRQfymg9kx6noo8t+at4rEsOO+4FvK30/8Tfvqy5H84dw72AtPo2
mbllr4mGAkqb9S3mfoCWSt38bK46cqKZf8ldJJs4B8sH1eWEMtVxUv7vgNnI4yZf
X3/2NoOUdFs1QUun8oGm2Evh82+4PAfJRemKybSIwi5a1GOoZQ7WGYViWsQch0mx
vEjsdQ1ays4zCU/EWGhSu4+WBx18C+sPaRNg1MB98fqyjWMph7XbbCysQptv7LIs
Es8wZkINul+HzKf8F47iapZO30QEGwawSxko+B0YyEbk6iXKzIiaPPbik3tgzdI=
=UfYI
-----END PGP SIGNATURE-----
