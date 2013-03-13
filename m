From: Yannick Brosseau <yannick.brosseau@gmail.com>
Subject: Re: [PATCH babeltrace 1/2] Added Python 3.0 or better
 requirement to the README file
Date: Wed, 13 Mar 2013 10:28:18 -0400
Message-ID: <51408D02.2050205__43740.6226214536$1363184956$gmane$org@gmail.com>
References: <1359640251-6133-1-git-send-email-jeremie.galarneau@efficios.com>
	<510BA252.3020604@gmail.com>
	<CA+jJMxv0tcbzd0m27586h_D3fY9e6-0Nd8Mt=-iKUOkcCH6E5g@mail.gmail.com>
	<513E9904.2050201@gmail.com>
	<CA+jJMxu+RekfzeVVNqF2_FhKCYJ3SWeQsCL8ETPZzP7YtbiUoA@mail.gmail.com>
	<20130313140610.GC16186@Krystal> <514089E7.1080705@gmail.com>
	<20130313142313.GA16532@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ie0-f176.google.com ([209.85.223.176])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <yannick.brosseau@gmail.com>) id 1UFmfK-0003RT-KY
	for lttng-dev@lists.lttng.org; Wed, 13 Mar 2013 10:28:26 -0400
Received: by mail-ie0-f176.google.com with SMTP id k13so1472827iea.7
	for <lttng-dev@lists.lttng.org>; Wed, 13 Mar 2013 07:28:21 -0700 (PDT)
In-Reply-To: <20130313142313.GA16532@Krystal>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

On 2013-03-13 10:23, Mathieu Desnoyers wrote:
> * Yannick Brosseau (yannick.brosseau@gmail.com) wrote:
>> On 2013-03-13 10:06, Mathieu Desnoyers wrote:
>>> Hi Yannick,
>>>
>>> Please list all the distro and distro versions you care about that still
>>> ship with python 2.7 by default today, along with the time-frame for
>>> which they are going to still be supported by the vendors, and whether
>>> those distributions allow users to install python 3.0 side-by-side with
>>> 2.7 or not.
>> Just to name 2: Centos/RHEL 6.x and Debian.
>>
>> CentOS/RHEL does not have a Python 3 package
>>
>> Debian is default to 2.7, can install python3, but will potentially
>> breaks apps that rely on python 2 if I set python 3 to default.
> For our python scripts to work, do we need python 3 to be default ?
>
> About RHEL6, interesting links:
>
> http://www.muktware.com/5203/google-says-red-hat-enterprise-linux-6-obsolete
>
> Something to think about ;)
>
Google can say what they want, RHEL 6 is still widely used (RHEL 5 is
still widely use...)

Personnally, it don't affect me much, since debian will probably switch
sooner or later, but seeing the number of request to have LTTng
supported on RHEL, it might be something to think about.

yannick
