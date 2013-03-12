From: =?ISO-8859-1?Q?J=E9r=E9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: [PATCH babeltrace 1/2] Added Python 3.0 or better
 requirement to the README file
Date: Tue, 12 Mar 2013 10:31:14 -0400
Message-ID: <CA+jJMxu+RekfzeVVNqF2_FhKCYJ3SWeQsCL8ETPZzP7YtbiUoA__4977.15839087522$1363098730$gmane$org@mail.gmail.com>
References: <1359640251-6133-1-git-send-email-jeremie.galarneau@efficios.com>
	<510BA252.3020604@gmail.com>
	<CA+jJMxv0tcbzd0m27586h_D3fY9e6-0Nd8Mt=-iKUOkcCH6E5g@mail.gmail.com>
	<513E9904.2050201@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-wg0-f42.google.com ([74.125.82.42])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jeremie.galarneau@gmail.com>) id 1UFQEa-000061-0A
	for lttng-dev@lists.lttng.org; Tue, 12 Mar 2013 10:31:20 -0400
Received: by mail-wg0-f42.google.com with SMTP id 12so3325012wgh.5
	for <lttng-dev@lists.lttng.org>; Tue, 12 Mar 2013 07:31:14 -0700 (PDT)
In-Reply-To: <513E9904.2050201@gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Although I agree it can prove to be an inconvenience for some users,
most distributions provide a Python 3 package at this point.

The reasoning is that since these bindings are still in development
and won't be integrated into the master branch for some time, the
effort needed to develop and test them while targeting two versions of
Python is hard to justify.

On Mon, Mar 11, 2013 at 10:55 PM, Yannick Brosseau
<yannick.brosseau@gmail.com> wrote:
> On 2013-02-01 08:54, J=E9r=E9mie Galarneau wrote:
>> As for as I know, the bindings do work with Python 2.7.
>> However, we have decided to no longer explicitly support older
>> versions of Python in order to make the bindings, along with future
>> developments, easily maintainable.
>>
> My main concern is that 2.7 is still the default version for many linux
> distribution, so it might be early to drop 2.7 support.
>
> Yannick
>
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
