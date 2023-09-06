Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6426CEB8FA5
	for <lttng-dev@archiver.kernel.org>; Wed,  6 Sep 2023 10:02:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1693994567;
	bh=izxU+PNcgODrV+J/WnA/8urY7zJ0DdberpWWIuY1IT8=;
	h=To:Date:References:In-Reply-To:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=h3ClbXCQyCXbJSi6kawVdwZc20dMuSqZHRDHcDbcBmNSpMnmvcdLIdL7Gt2q7PNLz
	 JBaGOiwaeCAqlIOzA1jChkPC5HMF+BMImhag38STJoa3NTY1K5H6jJuIrnpjVhZQnu
	 VYukgVW4lZtY9/BPHBEXXEE9ceQiaZ9BwEF/gUmxrwmNUojnLMhNzIHlA4QN0+taIi
	 YArSs7STgObKBFYAzOihH1IHE9BQGycKC6wai4IUme2yrYFI3AIogS/si5XTmhXIII
	 ZlCQ8sbSW1s0fmO8FjVBylPgS5rU0e9pz6QseBbtAk8bSRT+VpI0kOawzCofo/u5Av
	 NCNFS2izRyU+g==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4RgdGZ4YqYz2W0V;
	Wed,  6 Sep 2023 06:02:46 -0400 (EDT)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2043.outbound.protection.outlook.com [40.107.92.43])
 by lists.lttng.org (Postfix) with ESMTPS id 4RgdGY3Kzlz2W0T
 for <lttng-dev@lists.lttng.org>; Wed,  6 Sep 2023 06:02:45 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YexPG4Om23E03qVQo/Lwe2qTyZIyV/qq84amEuldhL0Dj38ziGEak8RRywZWtTnIOwu+xZ9kXNLQdS1mwWiAdehq1HhQpt6AU1UScrrPQj7qLCPS4UR0NTEYeSu7hrZWU3IkaEWTVO1gLYCKVUHtdNexKMKppPq9B2IhbLh0ofgu1U2ErVFl59NuIpstJCxgPVae/u0x8pcubuapRdN7HkZauT1Mv6gOU04Ah6uNBCfCgJP6BCSrYcA9pIQ4Mawf2gC2T1Y0MqOPMoQy3QpC5ZS2bzm6oOZuWd23656xx5DgJ254H8XrNUXwddCR9c1HLWGu36viVMiptRPTbnA++w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tZqvoLRXQBLuseM+1lQyrj9EPYLfCYJ908eB3Jz6HaI=;
 b=PHd7vi0asPsRiymlrRp/pQGWkGsB5f2Iwvk4RrC1XxaGWuByFBTYRIj3foqRqjmfL6GkKRq6UqdJ9U+3tRP2H/1aRXuZ/wIuntTDSgWrb2W/HTudE7+bv/RAYjYGVeOL99VXtHjkhSHNteDdfspZrtU0SNirq7neXv8kALTHZVl3om33LpurhsYpAF/UiBXIzvn94nys5+DtxxEo7aD6It3oi0u59x29eC9Y6o9Q3sNT7UqfHVcHSseVwpyNJDcuH9WlWd2z2wWvcsu4bfKoQZIYi3/xdaPA02QQQ3zUzWk4D/0sbl05mi9F6d2CSSIP3DUPylRMSJrCg0+2Ici0lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from MW3PR12MB4555.namprd12.prod.outlook.com (2603:10b6:303:59::20)
 by SA0PR12MB4383.namprd12.prod.outlook.com (2603:10b6:806:94::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Wed, 6 Sep
 2023 10:02:43 +0000
Received: from MW3PR12MB4555.namprd12.prod.outlook.com
 ([fe80::5acf:b492:72c8:6e99]) by MW3PR12MB4555.namprd12.prod.outlook.com
 ([fe80::5acf:b492:72c8:6e99%4]) with mapi id 15.20.6745.034; Wed, 6 Sep 2023
 10:02:42 +0000
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
Thread-Topic: [lttng-dev] LTTNG LIB UST Crash
Thread-Index: AQHZ38CUibDWq+jpPkCnQS40t4VDBrAMYgOAgAEwByU=
Date: Wed, 6 Sep 2023 10:02:42 +0000
Message-ID: <MW3PR12MB45557CD01005A03C4A5E84F2D9EFA@MW3PR12MB4555.namprd12.prod.outlook.com>
References: <MW3PR12MB4555EFAAF7F86C5EFA8DB849D9E8A@MW3PR12MB4555.namprd12.prod.outlook.com>
 <b16699e8-92de-2088-2912-e956443f4a3e@efficios.com>
In-Reply-To: <b16699e8-92de-2088-2912-e956443f4a3e@efficios.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW3PR12MB4555:EE_|SA0PR12MB4383:EE_
x-ms-office365-filtering-correlation-id: ff18b5d9-32c6-45d0-bda5-08dbaec06940
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: T07Xp6+UMwwASM97o7yOrHwODdulCOlqKQYO2js37uBb4HvPsdCP+Mu3ueP4pxCEkkCVVjpnt9uC3Nregr7V7cWD7s4qMgNd1IKHSHDVyXswPBWhHpG95pq7dYMXt9Fh2ZjOCAnGE+Rao5cU51fhxo89q/3rYQ42f2EmH7Yl1XkDKIJzlcoMP45mlRlR4byrf/G0M9v6QRiS9TTN4ghdwW3w4bdVmB7F/XMxovmIzsXIRKuGnVT4NEOtv6tmyOREGszwJ/sbqXqelJmw6lccSdwb8MVJ/n07zKeFSusQRAoD9MOHGfpeqNtNU39oB467Xqhe+aA2lt9zE3NHsZqYLZ6B7OkBxdDF94vIn7UuBAlbWSwNb/BoQw3bY4/MRihFIXXLeJtJN4iaMtx8l5JGKDLUErhh5E7nxCxcgKKrN3O6S2aIrD+aSCZTHiWvpc56qjv/+8BX49g6nEQDWeqFz2uFNwjNUmxFrOFQjU9l32RHqQ9d+gGHajxUDUnp4Fc07EUiTW2rz7cTfuR6QcLwE56iUYoYCydgN51tacfCS3PMcQcLDPhUVYz16Q4tbgS3hAieJtSBrcDhxcvn+s58YVQK2a+yxBZRT62leQFW+Mc=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW3PR12MB4555.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(346002)(39860400002)(396003)(136003)(366004)(1800799009)(186009)(451199024)(8676002)(8936002)(83380400001)(52536014)(966005)(1015004)(45080400002)(478600001)(76116006)(66946007)(66556008)(6916009)(66476007)(91956017)(66446008)(64756008)(26005)(6506007)(7696005)(71200400001)(53546011)(9686003)(41300700001)(2906002)(316002)(38070700005)(38100700002)(122000001)(5660300002)(55016003)(166002)(86362001)(19627405001)(33656002)(66899024);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Y4ierOCb9ZUnGgp9qpJLAIFq8l+CuqlrLJ2WdwoTM5iAObQGdbVscEC0C+?=
 =?iso-8859-1?Q?DmYoEJe7E5fJT1fNAHe6PrWZRNXLC/I/lIrItTolbfHIbaET+vLVFjGHEO?=
 =?iso-8859-1?Q?1vt4sJlXYbgwq/L57P45UBfJ9HZE7Ij08ThJimbSWdiRQzW3ljxMhZZZnU?=
 =?iso-8859-1?Q?Jcm0tdqwJ72e/mk38ra2wMi04ZHMGtIcn7F2WkA7JG7cLkB/A1naE0aBr4?=
 =?iso-8859-1?Q?TLCqBBmDeoJYGZcWDZ6j3G7Ng9l5jHAFaxEBm8mywA8st0NHNWPw+jWO1J?=
 =?iso-8859-1?Q?psH1yng5tNp8Z+rcu7NM6ViohakEzqEjyfknCY4pm2d6nzFi7YxJW8dy5d?=
 =?iso-8859-1?Q?8cJQAb/n9xFjTB31i8mzBLdYg3GFHVhcVSycRuqliFeozwAKJzE5oOYY9t?=
 =?iso-8859-1?Q?2/yEQ6CL5rqGyScBKg0w6FcQq48uHBf8Xkhvy42gSsx+e4gqCt6zwHc0ic?=
 =?iso-8859-1?Q?QE15EQt/mln1ukvoN4u+NyHAGvUltYrr8CSzSuEBmRf7g66sSPYeqU0Rzr?=
 =?iso-8859-1?Q?WhvGaeqwgapB7MvZaUo36LlTSj6WAm6+XJc8gONBq2iXacbur4EfSg1wRP?=
 =?iso-8859-1?Q?GeCf8HtG8vP1vxMvS6Pbag1SESv+eShmc8APlY/xjvfki9kb2ZTgcMQWg+?=
 =?iso-8859-1?Q?RcC4wKlarIMVBHTLClCfQYxefOvcDDEps8mfgr6Fv7ASSgFjxD7ATqoOem?=
 =?iso-8859-1?Q?QfgxJUkmtLhSU8HKr010wI0bzi7WwW0L9B7PoKOkqVf279xK2jHtb73Z5Y?=
 =?iso-8859-1?Q?ReLdRPX0UYav1/3s25ctlaxRKHb477nql4MoL23ltO/FSEkkjXlZGMAwjx?=
 =?iso-8859-1?Q?kDBgRNOEslMsbbd2RJDILLOugQWuoIi2FzIYdNclgP3xt4bIf+2u1XrAS+?=
 =?iso-8859-1?Q?occfbEz8P8OJAnVWgB96K2j92A5e6P6O0l1Fx+vLRRIKZUHNeTd00feQpF?=
 =?iso-8859-1?Q?h8/uNaOPqdtgfIcmTrLopyER1uyNv0SVQGWf0JBfEJC4mPQpmIhUmXSNZo?=
 =?iso-8859-1?Q?22q7aX3LVTmrpOUYMqE5GoABaPR/KAHhnijLyXlb0WLbFLVpkyPVjNqN6u?=
 =?iso-8859-1?Q?LFdhUD9Oj/Yu65toq4BLbth3gpZsyrvQ9XRWmVyEd+H8T4tMntryznFgVC?=
 =?iso-8859-1?Q?HvgENUCZvZTNO4wlPMHLZ6U1Wld77s4vv7mD6pzSZI7bvdK2R9+HArTmWJ?=
 =?iso-8859-1?Q?2AH4W23WRHL9+2ZexPAeY2gSGEjIUMf/bhpUUqSTrLsj5N6AAfTcZ9Cah6?=
 =?iso-8859-1?Q?dpUKKaB+/a45UvobGVkhvYjBWVmKaZnpiFUhAzSZGXimhsydjAVELWxurl?=
 =?iso-8859-1?Q?bhZS6HrUNuYsADpJr2tNG8WZNfSVnRmbZixrIF3x8vBBeZYvs04AKDvqPh?=
 =?iso-8859-1?Q?dJKALN3AfhfhSdrDVSffBiahqutxLTZ37WzQdKpnCxTfx8yDLEeCxE9K72?=
 =?iso-8859-1?Q?5FSnhKpPEeNVEtbQ+zAMmjDwKj+qqvJ6FvB4r8p9ldFInbcEcizV2Q5McK?=
 =?iso-8859-1?Q?3jfEJxRSWpnYMbitO0LQ/YJfY4ZYLVdtMWRe/itb2F1sBY50w7lkLRneoX?=
 =?iso-8859-1?Q?eP5NxjoaI2KmMh0lw4FUr0yU3cYT5jjE50v+JIYnbmz/DgeZNS8tW4uEsH?=
 =?iso-8859-1?Q?hkLshkc5+oUQA=3D?=
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4555.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff18b5d9-32c6-45d0-bda5-08dbaec06940
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2023 10:02:42.5825 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /piBkxbpaxvnH28/3ly63tiVbIb0ATL1UOblezoSCSf8IGm8VPRdGCX0fETZUX3Ks4WgoDvwPhiL7SqvuXctqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4383
Subject: Re: [lttng-dev] LTTNG LIB UST Crash
X-BeenThere: lttng-dev@lists.lttng.org
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: LTTng development list <lttng-dev.lists.lttng.org>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
From: Lakshmi Deverkonda via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Lakshmi Deverkonda <laksd@nvidia.com>
Content-Type: multipart/mixed; boundary="===============3666298167933949217=="
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

--===============3666298167933949217==
Content-Language: en-GB
Content-Type: multipart/alternative;
	boundary="_000_MW3PR12MB45557CD01005A03C4A5E84F2D9EFAMW3PR12MB4555namp_"

--_000_MW3PR12MB45557CD01005A03C4A5E84F2D9EFAMW3PR12MB4555namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Thanks for the reply. Issue is fixed after loading the tracing helpers.

I have one query wrt to logging wrt lttng on python3 application. Is there =
any way I can avoid the file logging and only trace via lttng ?

Regards,
Lakshmi


________________________________
From: Kienan Stewart <kstewart@efficios.com>
Sent: 05 September 2023 21:20
To: Lakshmi Deverkonda <laksd@nvidia.com>
Subject: Re: [lttng-dev] LTTNG LIB UST Crash

External email: Use caution opening links or attachments


Hi Lakshmi,

could you please provide us with the system details and version
information for LTTng tools and UST?

The bug reporting guidelines which cover the type of information
required to respond adequately questions can be found here:
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flttng.o=
rg%2Fcommunity%2F%23bug-reporting-guidelines&data=3D05%7C01%7Claksd%40nvidi=
a.com%7C087f25ce0bc54b0b0cf008dbae27e747%7C43083d15727340c1b7db39efd9ccc17a=
%7C0%7C0%7C638295258729072557%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiL=
CJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=3DZUKJj=
2JTtxWJNp9Prf8XjarnbPRPbLGXQy1Eou8AvRE%3D&reserved=3D0<https://lttng.org/co=
mmunity/#bug-reporting-guidelines>

Given that you are instrumenting a user space application, do you have a
minimal reproducer of the crash including the details of how the
application is invoked that you would be able to share?

Some types of user space applications required tracing helpers loaded
via LD_PRELOAD. More information can be found here
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flttng.o=
rg%2Fdocs%2Fv2.13%2F%23doc-prebuilt-ust-helpers&data=3D05%7C01%7Claksd%40nv=
idia.com%7C087f25ce0bc54b0b0cf008dbae27e747%7C43083d15727340c1b7db39efd9ccc=
17a%7C0%7C0%7C638295258729072557%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMD=
AiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=3Dg9=
HSdPQPqYw%2BdTXH9kKKyYjNZDX90NGArrUTW8UHp7s%3D&reserved=3D0<https://lttng.o=
rg/docs/v2.13/#doc-prebuilt-ust-helpers>

If you're unable to share code or other log files due to company policy,
or require responses within a guaranteed time frame, EfficiOS offers
commercial support services: https://nam11.safelinks.protection.outlook.com=
/?url=3Dhttps%3A%2F%2Fwww.efficios.com%2Fservices%2F&data=3D05%7C01%7Claksd=
%40nvidia.com%7C087f25ce0bc54b0b0cf008dbae27e747%7C43083d15727340c1b7db39ef=
d9ccc17a%7C0%7C0%7C638295258729072557%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wL=
jAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=
=3DYry9Y74Ydo9eHmC5uP0bhcueqYTNoXbXpyiOLIytShc%3D&reserved=3D0<https://www.=
efficios.com/services/>

thanks,
kienan

p.s. Sorry for forgetting to CC you in my earlier reply to the list!

On 2023-09-05 02:30, Lakshmi Deverkonda via lttng-dev wrote:
> Hi All,
>
> I am observing lttng crash while trying to interface LTTNG for one of my
> python3 application.
> I just tried the following things,
>
> Added "import lttngust " in the code.
>
> # lttng create clagd
> Session clagd created.
> Traces will be written in /root/lttng-traces/clagd-20230905-062210
>
> # lttng enable-event --python clagd
> #lttng start
>
> #service clagd start
> *
> *
> *cumulus-core: Running cl-support for core files
> "clagd-ust.95410.1693895062.core"*
>
> #0  0x00007f134fb938eb in raise () from /lib/x86_64-linux-gnu/libc.so.6
> #1  0x00007f134fb7e535 in abort () from /lib/x86_64-linux-gnu/libc.so.6
> #2  0x00007f134fb7e40f in ?? () from /lib/x86_64-linux-gnu/libc.so.6
> #3  0x00007f134fb8c1a2 in __assert_fail () from
> /lib/x86_64-linux-gnu/libc.so.6
> #4  0x00007f134f1a9677 in lttng_ust_add_fd_to_tracker () from
> /lib/x86_64-linux-gnu/liblttng-ust.so.0
> #5  0x00007f134f1bdcf4 in lttng_ust_elf_create () from
> /lib/x86_64-linux-gnu/liblttng-ust.so.0
> #6  0x00007f134f1bf8de in ?? () from /lib/x86_64-linux-gnu/liblttng-ust.s=
o.0
> #7  0x00007f134fc8f957 in dl_iterate_phdr () from
> /lib/x86_64-linux-gnu/libc.so.6
> #8  0x00007f134f1bff6b in lttng_ust_dl_update () from
> /lib/x86_64-linux-gnu/liblttng-ust.so.0
> #9  0x00007f134f1c061a in do_lttng_ust_statedump () from
> /lib/x86_64-linux-gnu/liblttng-ust.so.0
> #10 0x00007f134f1b5ca9 in lttng_handle_pending_statedump () from
> /lib/x86_64-linux-gnu/liblttng-ust.so.0
> #11 0x00007f134f1ab6d1 in ?? () from /lib/x86_64-linux-gnu/liblttng-ust.s=
o.0
> #12 0x00007f134f1ad7eb in ?? () from /lib/x86_64-linux-gnu/liblttng-ust.s=
o.0
> #13 0x00007f134ff0dfa3 in start_thread () from
> /lib/x86_64-linux-gnu/libpthread.so.0
> #14 0x00007f134fc5506f in clone () from /lib/x86_64-linux-gnu/libc.so.6
>
>
> When I stop the lttng session, I see another core
>
> #0  0x00007fad951988eb in raise () from /lib/x86_64-linux-gnu/libc.so.6
> [Current thread is 1 (Thread 0x7fad9331f700 (LWP 2221103))]
> (gdb) bt
> #0  0x00007fad951988eb in raise () from /lib/x86_64-linux-gnu/libc.so.6
> #1  0x00007fad95183535 in abort () from /lib/x86_64-linux-gnu/libc.so.6
> #2  0x00007fad9518340f in ?? () from /lib/x86_64-linux-gnu/libc.so.6
> #3  0x00007fad951911a2 in __assert_fail () from
> /lib/x86_64-linux-gnu/libc.so.6
> #4  0x00007fad947e8d9f in ?? () from /lib/x86_64-linux-gnu/liblttng-ust.s=
o.0
> #5  0x00007fad947e98e3 in shm_object_table_destroy () from
> /lib/x86_64-linux-gnu/liblttng-ust.so.0
> #6  0x00007fad947e4d9a in channel_destroy () from
> /lib/x86_64-linux-gnu/liblttng-ust.so.0
> #7  0x00007fad947ba6b5 in lttng_session_destroy () from
> /lib/x86_64-linux-gnu/liblttng-ust.so.0
> #8  0x00007fad947b47c6 in ?? () from /lib/x86_64-linux-gnu/liblttng-ust.s=
o.0
> #9  0x00007fad947b4bac in lttng_ust_objd_unref () from
> /lib/x86_64-linux-gnu/liblttng-ust.so.0
> #10 0x00007fad947b4bac in lttng_ust_objd_unref () from
> /lib/x86_64-linux-gnu/liblttng-ust.so.0
> #11 0x00007fad947b4bac in lttng_ust_objd_unref () from
> /lib/x86_64-linux-gnu/liblttng-ust.so.0
> #12 0x00007fad947b5304 in lttng_ust_objd_table_owner_cleanup () from
> /lib/x86_64-linux-gnu/liblttng-ust.so.0
> #13 0x00007fad947b2b75 in ?? () from /lib/x86_64-linux-gnu/liblttng-ust.s=
o.0
> #14 0x00007fad95512fa3 in start_thread () from
> /lib/x86_64-linux-gnu/libpthread.so.0
> #15 0x00007fad9525a06f in clone () from /lib/x86_64-linux-gnu/libc.so.6
>
>
> Can you please help here if I'm missing something. This is a critical
> task item for us but are currently stuck with multiple lttng crashes.
>
> Regards,
> Lakshmi
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists=
.lttng.org%2Fcgi-bin%2Fmailman%2Flistinfo%2Flttng-dev&data=3D05%7C01%7Claks=
d%40nvidia.com%7C087f25ce0bc54b0b0cf008dbae27e747%7C43083d15727340c1b7db39e=
fd9ccc17a%7C0%7C0%7C638295258729072557%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4w=
LjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdat=
a=3Dk3GLHQwri5y6mlLv4nO3XL97f2nuYLM2KHWN3%2FpbK1U%3D&reserved=3D0<https://l=
ists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>

--_000_MW3PR12MB45557CD01005A03C4A5E84F2D9EFAMW3PR12MB4555namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
Thanks for the reply. Issue is fixed after loading the tracing helpers.&nbs=
p;</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
I have one query wrt to logging wrt lttng on python3 application. Is there =
any way I can avoid the file logging and only trace via lttng ?</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
Regards,</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
Lakshmi</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
<div id=3D"appendonsend"></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div dir=3D"ltr"><font face=3D"Calibri, sans-serif" style=3D"font-size: 11p=
t; color: rgb(0, 0, 0);"><b>From:</b> Kienan Stewart &lt;kstewart@efficios.=
com&gt;<br>
</font></div>
<div id=3D"divRplyFwdMsg" dir=3D"ltr" class=3D"elementToProof"><font face=
=3D"Calibri, sans-serif" style=3D"font-size: 11pt; color: rgb(0, 0, 0);"><b=
>Sent:</b> 05 September 2023 21:20<br>
</font></div>
<div dir=3D"ltr"><font face=3D"Calibri, sans-serif" style=3D"font-size: 11p=
t; color: rgb(0, 0, 0);"><b>To:</b> Lakshmi Deverkonda &lt;laksd@nvidia.com=
&gt;<br>
<b>Subject:</b> Re: [lttng-dev] LTTNG LIB UST Crash</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt"=
>
<div class=3D"PlainText">External email: Use caution opening links or attac=
hments<br>
<br>
<br>
Hi Lakshmi,<br>
<br>
could you please provide us with the system details and version<br>
information for LTTng tools and UST?<br>
<br>
The bug reporting guidelines which cover the type of information<br>
required to respond adequately questions can be found here:<br>
<a href=3D"https://lttng.org/community/#bug-reporting-guidelines" data-auth=
=3D"NotApplicable" id=3D"OWA3f4a850b-3405-38f8-5d3c-19612cbc7d63" class=3D"=
OWAAutoLink">https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A=
%2F%2Flttng.org%2Fcommunity%2F%23bug-reporting-guidelines&amp;data=3D05%7C0=
1%7Claksd%40nvidia.com%7C087f25ce0bc54b0b0cf008dbae27e747%7C43083d15727340c=
1b7db39efd9ccc17a%7C0%7C0%7C638295258729072557%7CUnknown%7CTWFpbGZsb3d8eyJW=
IjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C=
%7C&amp;sdata=3DZUKJj2JTtxWJNp9Prf8XjarnbPRPbLGXQy1Eou8AvRE%3D&amp;reserved=
=3D0</a><br>
<br>
Given that you are instrumenting a user space application, do you have a<br=
>
minimal reproducer of the crash including the details of how the<br>
application is invoked that you would be able to share?<br>
<br>
Some types of user space applications required tracing helpers loaded<br>
via LD_PRELOAD. More information can be found here<br>
<a href=3D"https://lttng.org/docs/v2.13/#doc-prebuilt-ust-helpers" data-aut=
h=3D"NotApplicable" id=3D"OWA96825b7c-b419-eb14-e568-b2d7dbf4393e" class=3D=
"OWAAutoLink">https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3=
A%2F%2Flttng.org%2Fdocs%2Fv2.13%2F%23doc-prebuilt-ust-helpers&amp;data=3D05=
%7C01%7Claksd%40nvidia.com%7C087f25ce0bc54b0b0cf008dbae27e747%7C43083d15727=
340c1b7db39efd9ccc17a%7C0%7C0%7C638295258729072557%7CUnknown%7CTWFpbGZsb3d8=
eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7=
C%7C%7C&amp;sdata=3Dg9HSdPQPqYw%2BdTXH9kKKyYjNZDX90NGArrUTW8UHp7s%3D&amp;re=
served=3D0</a><br>
<br>
If you're unable to share code or other log files due to company policy,<br=
>
or require responses within a guaranteed time frame, EfficiOS offers<br>
commercial support services: <a href=3D"https://www.efficios.com/services/"=
 data-auth=3D"NotApplicable" id=3D"OWA38824125-53fc-83a2-5ed5-c30d274f32d0"=
 class=3D"OWAAutoLink">
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fwww.eff=
icios.com%2Fservices%2F&amp;data=3D05%7C01%7Claksd%40nvidia.com%7C087f25ce0=
bc54b0b0cf008dbae27e747%7C43083d15727340c1b7db39efd9ccc17a%7C0%7C0%7C638295=
258729072557%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLC=
JBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=3DYry9Y74Ydo9eHmC5uP=
0bhcueqYTNoXbXpyiOLIytShc%3D&amp;reserved=3D0</a><br>
<br>
thanks,<br>
kienan<br>
<br>
p.s. Sorry for forgetting to CC you in my earlier reply to the list!<br>
<br>
On 2023-09-05 02:30, Lakshmi Deverkonda via lttng-dev wrote:<br>
&gt; Hi All,<br>
&gt;<br>
&gt; I am observing lttng crash while trying to interface LTTNG for one of =
my<br>
&gt; python3 application.<br>
&gt; I just tried the following things,<br>
&gt;<br>
&gt; Added &quot;import lttngust &quot; in the code.<br>
&gt;<br>
&gt; # lttng create clagd<br>
&gt; Session clagd created.<br>
&gt; Traces will be written in /root/lttng-traces/clagd-20230905-062210<br>
&gt;<br>
&gt; # lttng enable-event --python clagd<br>
&gt; #lttng start<br>
&gt;<br>
&gt; #service clagd start<br>
&gt; *<br>
&gt; *<br>
&gt; *cumulus-core: Running cl-support for core files<br>
&gt; &quot;clagd-ust.95410.1693895062.core&quot;*<br>
&gt;<br>
&gt; #0&nbsp; 0x00007f134fb938eb in raise () from /lib/x86_64-linux-gnu/lib=
c.so.6<br>
&gt; #1&nbsp; 0x00007f134fb7e535 in abort () from /lib/x86_64-linux-gnu/lib=
c.so.6<br>
&gt; #2&nbsp; 0x00007f134fb7e40f in ?? () from /lib/x86_64-linux-gnu/libc.s=
o.6<br>
&gt; #3&nbsp; 0x00007f134fb8c1a2 in __assert_fail () from<br>
&gt; /lib/x86_64-linux-gnu/libc.so.6<br>
&gt; #4&nbsp; 0x00007f134f1a9677 in lttng_ust_add_fd_to_tracker () from<br>
&gt; /lib/x86_64-linux-gnu/liblttng-ust.so.0<br>
&gt; #5&nbsp; 0x00007f134f1bdcf4 in lttng_ust_elf_create () from<br>
&gt; /lib/x86_64-linux-gnu/liblttng-ust.so.0<br>
&gt; #6&nbsp; 0x00007f134f1bf8de in ?? () from /lib/x86_64-linux-gnu/libltt=
ng-ust.so.0<br>
&gt; #7&nbsp; 0x00007f134fc8f957 in dl_iterate_phdr () from<br>
&gt; /lib/x86_64-linux-gnu/libc.so.6<br>
&gt; #8&nbsp; 0x00007f134f1bff6b in lttng_ust_dl_update () from<br>
&gt; /lib/x86_64-linux-gnu/liblttng-ust.so.0<br>
&gt; #9&nbsp; 0x00007f134f1c061a in do_lttng_ust_statedump () from<br>
&gt; /lib/x86_64-linux-gnu/liblttng-ust.so.0<br>
&gt; #10 0x00007f134f1b5ca9 in lttng_handle_pending_statedump () from<br>
&gt; /lib/x86_64-linux-gnu/liblttng-ust.so.0<br>
&gt; #11 0x00007f134f1ab6d1 in ?? () from /lib/x86_64-linux-gnu/liblttng-us=
t.so.0<br>
&gt; #12 0x00007f134f1ad7eb in ?? () from /lib/x86_64-linux-gnu/liblttng-us=
t.so.0<br>
&gt; #13 0x00007f134ff0dfa3 in start_thread () from<br>
&gt; /lib/x86_64-linux-gnu/libpthread.so.0<br>
&gt; #14 0x00007f134fc5506f in clone () from /lib/x86_64-linux-gnu/libc.so.=
6<br>
&gt;<br>
&gt;<br>
&gt; When I stop the lttng session, I see another core<br>
&gt;<br>
&gt; #0&nbsp; 0x00007fad951988eb in raise () from /lib/x86_64-linux-gnu/lib=
c.so.6<br>
&gt; [Current thread is 1 (Thread 0x7fad9331f700 (LWP 2221103))]<br>
&gt; (gdb) bt<br>
&gt; #0&nbsp; 0x00007fad951988eb in raise () from /lib/x86_64-linux-gnu/lib=
c.so.6<br>
&gt; #1&nbsp; 0x00007fad95183535 in abort () from /lib/x86_64-linux-gnu/lib=
c.so.6<br>
&gt; #2&nbsp; 0x00007fad9518340f in ?? () from /lib/x86_64-linux-gnu/libc.s=
o.6<br>
&gt; #3&nbsp; 0x00007fad951911a2 in __assert_fail () from<br>
&gt; /lib/x86_64-linux-gnu/libc.so.6<br>
&gt; #4&nbsp; 0x00007fad947e8d9f in ?? () from /lib/x86_64-linux-gnu/libltt=
ng-ust.so.0<br>
&gt; #5&nbsp; 0x00007fad947e98e3 in shm_object_table_destroy () from<br>
&gt; /lib/x86_64-linux-gnu/liblttng-ust.so.0<br>
&gt; #6&nbsp; 0x00007fad947e4d9a in channel_destroy () from<br>
&gt; /lib/x86_64-linux-gnu/liblttng-ust.so.0<br>
&gt; #7&nbsp; 0x00007fad947ba6b5 in lttng_session_destroy () from<br>
&gt; /lib/x86_64-linux-gnu/liblttng-ust.so.0<br>
&gt; #8&nbsp; 0x00007fad947b47c6 in ?? () from /lib/x86_64-linux-gnu/libltt=
ng-ust.so.0<br>
&gt; #9&nbsp; 0x00007fad947b4bac in lttng_ust_objd_unref () from<br>
&gt; /lib/x86_64-linux-gnu/liblttng-ust.so.0<br>
&gt; #10 0x00007fad947b4bac in lttng_ust_objd_unref () from<br>
&gt; /lib/x86_64-linux-gnu/liblttng-ust.so.0<br>
&gt; #11 0x00007fad947b4bac in lttng_ust_objd_unref () from<br>
&gt; /lib/x86_64-linux-gnu/liblttng-ust.so.0<br>
&gt; #12 0x00007fad947b5304 in lttng_ust_objd_table_owner_cleanup () from<b=
r>
&gt; /lib/x86_64-linux-gnu/liblttng-ust.so.0<br>
&gt; #13 0x00007fad947b2b75 in ?? () from /lib/x86_64-linux-gnu/liblttng-us=
t.so.0<br>
&gt; #14 0x00007fad95512fa3 in start_thread () from<br>
&gt; /lib/x86_64-linux-gnu/libpthread.so.0<br>
&gt; #15 0x00007fad9525a06f in clone () from /lib/x86_64-linux-gnu/libc.so.=
6<br>
&gt;<br>
&gt;<br>
&gt; Can you please help here if I'm missing something. This is a critical<=
br>
&gt; task item for us but are currently stuck with multiple lttng crashes.<=
br>
&gt;<br>
&gt; Regards,<br>
&gt; Lakshmi<br>
&gt;<br>
&gt; _______________________________________________<br>
&gt; lttng-dev mailing list<br>
&gt; lttng-dev@lists.lttng.org<br>
&gt; <a href=3D"https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev"=
 data-auth=3D"NotApplicable" id=3D"OWA8f253664-9e51-7a7b-0578-f00850ee1124"=
 class=3D"OWAAutoLink">
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.l=
ttng.org%2Fcgi-bin%2Fmailman%2Flistinfo%2Flttng-dev&amp;data=3D05%7C01%7Cla=
ksd%40nvidia.com%7C087f25ce0bc54b0b0cf008dbae27e747%7C43083d15727340c1b7db3=
9efd9ccc17a%7C0%7C0%7C638295258729072557%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC=
4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&am=
p;sdata=3Dk3GLHQwri5y6mlLv4nO3XL97f2nuYLM2KHWN3%2FpbK1U%3D&amp;reserved=3D0=
</a><br>
</div>
</span></font></div>
</body>
</html>

--_000_MW3PR12MB45557CD01005A03C4A5E84F2D9EFAMW3PR12MB4555namp_--

--===============3666298167933949217==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============3666298167933949217==--
