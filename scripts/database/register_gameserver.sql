-- Register Game Server ID 1 in Login Server database
USE ac47_server_ls;

-- Insert Game Server with ID=1, allow all IPs (*), password=GiGatRoon
INSERT INTO gameservers (id, mask, password) 
VALUES (1, '*', 'GiGatRoon')
ON DUPLICATE KEY UPDATE 
  mask = '*', 
  password = 'GiGatRoon';

-- Verify registration
SELECT * FROM gameservers WHERE id = 1;
