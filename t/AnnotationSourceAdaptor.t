# Copyright [1999-2016] Wellcome Trust Sanger Institute and the EMBL-European Bioinformatics Institute
# 
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# 
#      http://www.apache.org/licenses/LICENSE-2.0
# 
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

use strict;
use warnings;

use Test::More;
use Test::Exception;
use FindBin qw($Bin);

use lib $Bin;
use VEPTestingConfig;
my $test_cfg = VEPTestingConfig->new();

## BASIC TESTS
##############

# use test
use_ok('Bio::EnsEMBL::VEP::AnnotationSourceAdaptor');

my $asa = Bio::EnsEMBL::VEP::AnnotationSourceAdaptor->new();
ok($asa, 'new is defined');

is(ref($asa), 'Bio::EnsEMBL::VEP::AnnotationSourceAdaptor', 'check class');

# need to get a config object for further tests
use_ok('Bio::EnsEMBL::VEP::Config');

my $cfg_hash = $test_cfg->base_testing_cfg;

my $cfg = Bio::EnsEMBL::VEP::Config->new($cfg_hash);
ok($cfg, 'get new config object');

ok($asa = Bio::EnsEMBL::VEP::AnnotationSourceAdaptor->new({config => $cfg}), 'new with config');



## METHOD CALLS
###############

is_deeply(
  $asa->get_all_from_cache(),
  [
    bless( {
      'serializer_type' => 'storable',
      'dir' => $test_cfg->{cache_dir}
    }, 'Bio::EnsEMBL::VEP::AnnotationSource::Cache::Transcript' )
  ],
  'get_all_from_cache'
);


is_deeply(
  $asa->get_all(),
  [
    bless( {
      'serializer_type' => 'storable',
      'dir' => $test_cfg->{cache_dir}
    }, 'Bio::EnsEMBL::VEP::AnnotationSource::Cache::Transcript' )
  ],
  'get_all'
);



done_testing();