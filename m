From: ravi <ravi@linux.vnet.ibm.com>
Subject: Re: Support for new arch 'ppc64le'
Date: Wed, 12 Mar 2014 15:57:43 +0530
Message-ID: <5320369F.3060501__48845.6854517155$1394620126$gmane$org@linux.vnet.ibm.com>
References: <5313D494.5040508@linux.vnet.ibm.com>
	<796190728.353.1394566108995.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from e28smtp07.in.ibm.com ([122.248.162.7])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <ravi@linux.vnet.ibm.com>) id 1WNgOC-0006AD-DY
	for lttng-dev@lists.lttng.org; Wed, 12 Mar 2014 06:27:59 -0400
Received: from /spool/local
	by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <lttng-dev@lists.lttng.org> from <ravi@linux.vnet.ibm.com>;
	Wed, 12 Mar 2014 15:57:49 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
	by d28dlp02.in.ibm.com (Postfix) with ESMTP id A04753940023
	for <lttng-dev@lists.lttng.org>; Wed, 12 Mar 2014 15:57:44 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
	by d28relay05.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	s2CARmCR3473826
	for <lttng-dev@lists.lttng.org>; Wed, 12 Mar 2014 15:57:49 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
	by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
	s2CARhAS004849
	for <lttng-dev@lists.lttng.org>; Wed, 12 Mar 2014 15:57:44 +0530
In-Reply-To: <796190728.353.1394566108995.JavaMail.zimbra@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev@lists.lttng.org, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
List-Id: lttng-dev@lists.lttng.org


On 03/12/2014 12:58 AM, Mathieu Desnoyers wrote:
> ----- Original Message -----
>
>> From: "ravi" <ravi@linux.vnet.ibm.com>
>> To: lttng-dev@lists.lttng.org
>> Sent: Sunday, March 2, 2014 8:02:12 PM
>> Subject: [lttng-dev] Support for new arch 'ppc64le'
>> Hi,
>> We are in the process of adding support for new architecture 'ppc64le'
>> (PowerPC 64 Little Endian) and as part of that, We have worked with libtool
>> maintainer to get alpha release (links below) which has all the needed bits
>> to support building on ppc64le arch.
>> ftp://alpha.gnu.org/gnu/libtool/libtool-2.4.2.418.tar.gz(1.6MB)
>> ftp://alpha.gnu.org/gnu/libtool/libtool-2.4.2.418.tar.xz(920KB)
>> (A stable libtool release is expected soon this year)
>> ' userspace-rcu-0.8.1' didn't build on 'ppc64le' system because of outdated
>> libtoo.m4/config.guess files.
>> Latest ' liburcu' source package we picked is from :
>> http://lttng.org/files/urcu/userspace-rcu-0.8.1.tar.bz2
>> Along with changes to libtool related files, we have found a patch available
>> in ubuntu src repo, which is required to build 'liburcu' successfully on
>> 'ppc64le' system.
>> Im attaching the same patch which is created on top of "liburcu-0.7.7-1"...
>> hence we request you to apply attached patch , and spin off a new version of
>> 'liburcu' using the latest libtool alpha release . So that we can test
>> ppc64le fixes.
>> Your response is highly appreciated
> Hi,
>
> I see that the patch you propose adds both "powerpc64le" and "aarch64" entries. Why are there two of them ?
I think the entry "aarch64" entry is related to arm64 archtype. I will 
try to contact the original author of the patch and reconfirm.
>
> Moreover, it might be a bit aggressive to package the liburcu tarballs with an alpha version of libtool. When we
> understand more about the need for one or two specific entries into the configure.ac of liburcu, then we can add
> them, but until there is a stable version of libtool supporting those, you will probably have to create your own
> tarballs from the userspace RCU git repository using "make dist" against your alpha libtool.
okay.
>
> Thoughts ?
>
> Thanks,
>
> Mathieu
>
>> --
>> Ravindran
>> IBM LinuxTechnologyCenter
>> _______________________________________________
>> lttng-dev mailing list
>> lttng-dev@lists.lttng.org
>> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Ravindran
IBM LinuxTechnologyCenter
