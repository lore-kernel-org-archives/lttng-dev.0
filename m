From: Yannick Brosseau <yannick.brosseau@gmail.com>
Subject: Re: [PATCH babeltrace 1/2] Added Python 3.0 or better
 requirement to the README file
Date: Wed, 13 Mar 2013 10:20:49 -0400
Message-ID: <51408B41.6070809__34843.706052243$1363184506$gmane$org@gmail.com>
References: <1359640251-6133-1-git-send-email-jeremie.galarneau@efficios.com>
	<510BA252.3020604@gmail.com>
	<CA+jJMxv0tcbzd0m27586h_D3fY9e6-0Nd8Mt=-iKUOkcCH6E5g@mail.gmail.com>
	<513E9904.2050201@gmail.com>
	<CA+jJMxu+RekfzeVVNqF2_FhKCYJ3SWeQsCL8ETPZzP7YtbiUoA@mail.gmail.com>
	<20130313140610.GC16186@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ia0-f173.google.com ([209.85.210.173])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <yannick.brosseau@gmail.com>) id 1UFmY5-0003LL-4F
	for lttng-dev@lists.lttng.org; Wed, 13 Mar 2013 10:20:57 -0400
Received: by mail-ia0-f173.google.com with SMTP id h37so1024437iak.18
	for <lttng-dev@lists.lttng.org>; Wed, 13 Mar 2013 07:20:51 -0700 (PDT)
In-Reply-To: <20130313140610.GC16186@Krystal>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

On 2013-03-13 10:06, Mathieu Desnoyers wrote:
> Hi Yannick,
>
> Please list all the distro and distro versions you care about that still
> ship with python 2.7 by default today, along with the time-frame for
> which they are going to still be supported by the vendors, and whether
> those distributions allow users to install python 3.0 side-by-side with
> 2.7 or not.
Just to name 2: Centos/RHEL 6.x and Debian.

CentOS/RHEL does not have a Python 3 package

Debian is default to 2.7, can install python3, but will potentially
breaks apps that rely on python 2 if I set python 3 to default.



> Thanks,
>
> Mathieu
>
> * J=E9r=E9mie Galarneau (jeremie.galarneau@efficios.com) wrote:
>> Although I agree it can prove to be an inconvenience for some users,
>> most distributions provide a Python 3 package at this point.
>>
>> The reasoning is that since these bindings are still in development
>> and won't be integrated into the master branch for some time, the
>> effort needed to develop and test them while targeting two versions of
>> Python is hard to justify.
>>
>> On Mon, Mar 11, 2013 at 10:55 PM, Yannick Brosseau
>> <yannick.brosseau@gmail.com> wrote:
>>> On 2013-02-01 08:54, J=E9r=E9mie Galarneau wrote:
>>>> As for as I know, the bindings do work with Python 2.7.
>>>> However, we have decided to no longer explicitly support older
>>>> versions of Python in order to make the bindings, along with future
>>>> developments, easily maintainable.
>>>>
>>> My main concern is that 2.7 is still the default version for many linux
>>> distribution, so it might be early to drop 2.7 support.
>>>
>>> Yannick
>>>
>>>
>>> _______________________________________________
>>> lttng-dev mailing list
>>> lttng-dev@lists.lttng.org
>>> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>> _______________________________________________
>> lttng-dev mailing list
>> lttng-dev@lists.lttng.org
>> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
