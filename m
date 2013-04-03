From: Simon Marchi <simon.marchi@polymtl.ca>
Subject: Re: [PATCH lttng-tools] lttng cli: Accept human
 readable sizes for --subbuf-size
Date: Tue, 2 Apr 2013 23:38:29 -0400
Message-ID: <CAFXXi0=2qORZfkr+GkoC7E-+idFySUWN-Lh5b8_ggutZbknG0w__48730.1180874512$1364960388$gmane$org@mail.gmail.com>
References: <1364935514-11042-1-git-send-email-simon.marchi@polymtl.ca>
	<515B9986.7080802@polymtl.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ie0-f178.google.com ([209.85.223.178])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <thundersim@gmail.com>) id 1UNEXR-0003TN-26
	for lttng-dev@lists.lttng.org; Tue, 02 Apr 2013 23:39:05 -0400
Received: by mail-ie0-f178.google.com with SMTP id bn7so1239299ieb.9
	for <lttng-dev@lists.lttng.org>; Tue, 02 Apr 2013 20:38:59 -0700 (PDT)
In-Reply-To: <515B9986.7080802@polymtl.ca>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: =?ISO-8859-1?Q?Rapha=EBl_Beamonte?= <raphael.beamonte@polymtl.ca>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

On 2 April 2013 22:52, Rapha=EBl Beamonte <raphael.beamonte@polymtl.ca> wro=
te:
> On 2013-04-02 16:45, Simon Marchi wrote:
>> --subbuf-size accepts sizes such as:
>>
>> - 123 -> 123
>> - 123k or 123K -> 123 * 1024
>> - 123m or 123M -> 123 * 1024 * 1024
>> - 123g or 123G -> 123 * 1024 * 1024 * 1024
>
> I don't really like using non-SI prefixes such as "K", "m" or "g" (well,
> in fact "m" is an SI prefix but for milli, not mega).
> I think that would be better to only use "k", "M" and "G".

Agreed. I'll do that.

Simon
