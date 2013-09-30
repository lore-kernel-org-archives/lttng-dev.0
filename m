From: "Ikaheimonen, JP" <jp_ikaheimonen@mentor.com>
Subject: Re: Exclusion event support patches
Date: Mon, 30 Sep 2013 05:16:02 +0000
Message-ID: <009B25148989C6458484484699278506E538A822__34920.6512830735$1380518223$gmane$org@EU-MBX-01.mgc.mentorg.com>
References: <48CF5AC71E61DB46B70D0F388054EFFD26793BF7@VAL-E-02.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from relay1.mentorg.com ([192.94.38.131])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jp_ikaheimonen@mentor.com>) id 1VQVq7-0003iq-L9
	for lttng-dev@lists.lttng.org; Mon, 30 Sep 2013 01:16:16 -0400
In-Reply-To: <48CF5AC71E61DB46B70D0F388054EFFD26793BF7@VAL-E-02.valcartier.drdc-rddc.gc.ca>
Content-Language: en-US
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>, "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

-----Original Message-----
From: Thibault, Daniel [mailto:Daniel.Thibault@drdc-rddc.gc.ca] 
Sent: 27. syyskuuta 2013 16:14
To: lttng-dev@lists.lttng.org
Cc: Ikaheimonen, JP
Subject: RE: [lttng-dev] Exclusion event support patches

-----Message d'origine-----
Date: Fri, 27 Sep 2013 07:14:24 +0000
From: "Ikaheimonen, JP" <jp_ikaheimonen@mentor.com>

>> The exclusions are embedded into the event name so that internally, 
>> the event name will be
>>
>> 'a*ac*,ad*'

>   This takes advantage of the current wildcard restriction: the asterisk can only appear once in the name, at the end of the string -an asterisk is thus a string terminator.  This means that the exclusions in the name actually don't need a comma either!  The internal event name for 'a*' --exclude 'ac*,ad*' could thus be:

>'a*ac*ad*'

>> This new scheme of the event name string is parsed and handled wherever necessary. This implementation poses new restrictions to event names:
>> 1) An event name must not contain the character '*'.
>> 2) An event name can contain a ',' character, but you cannot use it in the exclusion specification.

>   If we used this format, this restriction on comma use would be dropped.

The excluded events may be single events, and not necessarily end in wildcards.
Consider
lttng enable-event 'a*' --exclude 'a1,a2,a3'

Here we need some sort of separator.

JP Ikaheimonen | SW Development Engineer http://go.mentor.com/sourceryanalyzer
Mentor Embedded(tm) | Nucleus(r) | Linux(r) | Android(tm) | Services | UI | Multi-OS
Android is a trademark of Google Inc. Use of this trademark is subject to Google Permissions.
Linux is the registered trademark of Linus Torvalds in the U.S. and other countries.
